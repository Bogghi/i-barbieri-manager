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
}