<?php

namespace App\DataAccess;

use PDO;

class DataAccess
{
    protected ?PDO $pdo = null;

    public function connectPdo(): void
    {
        if(!$this->pdo){
            $this->pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4', DB_USER, DB_PASSWORD);
        }
    }

    public function get($table, $args = null): array
    {
        $this->connectPdo();

        $columns = [];
        $values = [];
        if($args && is_array($args)) {
            foreach ($args as $col => $arg) {
                $operator = in_array($arg[0], ['>','<','!=','like']) ? $arg[0] : '=';
                $columns[] = "$col $operator ?";
                $values[] = $operator !== '=' ? ltrim($arg, '><!=like') : $arg;
            }
        }
        $wherePart = $args ? 'where '.implode(' and ', $columns) : '';

        $params = $values;

        $result = [];
        $sql = "select * from $table ".$wherePart;
        $stmt = $this->pdo->prepare($sql);
        try {
            $exec = $stmt->execute($params);
            if($exec) {
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            }
        }catch (\PDOException $E) {
            $stmt->debugDumpParams();
            //ToDo: log the exception
        }

        return $result;
    }

    public function customQuery(string $query): array
    {
        $result = [];

        try{
            $stmt = $this->pdo->prepare($query);
            $exec = $stmt->execute();
            if($exec) {
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            }
        }catch (\PDOException $E){
            //ToDo: log the exception
        }

        return $result;
    }
}