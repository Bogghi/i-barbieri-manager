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

    public function get(string $table, $args = null): array
    {
        $this->connectPdo();

        $columns = [];
        $values = [];
        if($args && is_array($args)) {
            foreach ($args as $col => $arg) {
                $argStr = "$arg";
                $operator = in_array($argStr[0], ['>','<','!=','like']) ? $argStr[0] : '=';
                $columns[] = "$col $operator ?";
                $values[] = $operator !== '=' ? ltrim($argStr, '><!=like') : $argStr;
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
        $this->connectPdo();
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

    public function add(string $table, ?array $args = null): array
    {
        $this->connectPdo();

        $result = [];
        if(!$args){
            return $result;
        }

        $base = "INSERT INTO $table ";
        $cols = ['cols' => [], 'placeholders' => []];
        $params = [];

        foreach ($args as $col => $val) {
            $cols['cols'][] = $col;
            $cols['placeholders'][] = '?';
            $params[] = $val;
        }

        try {
            $sql = $base.'('.implode(',', $cols['cols']).') VALUES ('.implode(',', $cols['placeholders']).');';
            $stmt = $this->pdo->prepare($sql);
            $exec = $stmt->execute($params);
            if($exec) {
                $result[] = $this->pdo->lastInsertId();
            }
        }catch (\PDOException $E) {
            var_dump($E->getMessage());
            //ToDo: log the exception
        }

        return $result;
    }
}