<?php

namespace App\controllers;

use App\DataAccess\DataAccess;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

class BarberStoresController extends DataAccess
{
    public function getStores(Request $request, Response $response, $args): Response
    {
        $result['barberStores'] = $this->get('barber_stores');

        $response->getBody()->write(json_encode($result));

        return $response
            ->withHeader('Content-Type', 'application/json');
    }

    public function getOpenReservation(Request $request, Response $response, $args): Response
    {
        $result = ['slots' => []];

        $date = $args['year'].'/'.$args['month'].'/'.$args['day'];

        $weekDaySchedules = $this->customQuery("select * from barber_store_schedules where weekday = lower(dayname('$date'))");
        $reservations = $this->get(table: 'barber_store_reservations', args: ['day' => $date, 'barber_id' => $args['barberId']]);
        $serviceData = $this->get(table: 'barber_store_services', args: ['barber_service_id' => $args['serviceId']]);

        $duration = (int)$serviceData[0]['duration'] > 0 ? $serviceData[0]['duration'] : 30 ;
        foreach ($weekDaySchedules as $schedule) {
            $slotStart = strtotime($schedule['opening']);
            $scheduledClosing = strtotime($schedule['closing']);

            while($slotStart < $scheduledClosing) {
                $validSlot = true;
                $slotEnd = strtotime("+$duration minutes", $slotStart);

                foreach ($reservations as $reservation) {
                    $startTime = strtotime($reservation['start_time']);
                    $endTime = strtotime($reservation['end_time']);

                    if($startTime >= $slotStart || $slotEnd <= $endTime) {
                        $validSlot = false;
                        break;
                    }
                }

                if($validSlot) {
                    $result['slots'][] = [
                        'startTime' => date('H:i', $slotStart),
                        'endTime' => date('H:i', $slotEnd)
                    ];
                }
                $slotStart = $slotEnd;
            }
        }

        $response->getBody()->write(json_encode($result));
        return $response
            ->withHeader('Content-Type', 'application/json');
    }

    public function bookReservation(Request $request, Response $response, $args): Response
    {
        $result = [];

        $body = $request->getParsedBody();

        $day = $args['year'].'/'.$args['month'].'/'.$args['day'];
        $barberId = $args['barberId'];
        $serviceId = $args['serviceId'];
        $start = $args['start'];
        $end = $args['end'];

        $phone = $body['phone'] ?? 0;

        try {
            $result['reservationId'] = $this->add(
                table: 'barber_store_reservations',
                args: [
                    'barber_store_id' => 12,
                    'barber_id' => $barberId,
                    'barber_store_service_id' => $serviceId,
                    'day' => $day,
                    'start_time' => $start,
                    'end_time' => $end,
                    'phone' => $phone
                ]
            )[0];
        }catch (\Exception $E) {

        }

        return $this->prepareResponse($response, $result);
    }

    public function addOrder(Request $request, Response $response, $args): Response
    {
        $this->debug = true;
        $result = [];

        $body = $request->getParsedBody();

        $reservationId = $body['reservation_id'] ?? null;
        $amount = $body['amount'] ?? null;
        $items = isset($body['items']) ? json_decode($body['items'], true) : null;

        if($amount && $items) {
            $orderId = $this->add(
                table: 'orders',
                args: [
                    'barber_store_id' => 12,
                    'reservation_id' => $reservationId,
                    'amount' => $amount
                ]
            )[0];

            foreach ($items as $item) {
                $this->add(
                    table: 'orders_items',
                    args: [
                        'order_id' => $orderId,
                        'barber_store_service_id' => $item['id'],
                        'quantity' => $item['quantity']
                    ]
                );
            }
            $result['orderId'] = $orderId;
            $result['result'] = 'OK';
        }
        else {
            $result = self::INVALID_PARAM_MESSAGE;
        }

        return $this->prepareResponse($response, $result);
    }
}