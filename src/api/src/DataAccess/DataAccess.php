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

    public function get($table): array
    {
        $this->connectPdo();

        $result = [];
        $stmt = $this->pdo->prepare("select * from ".$table);
        $exec = $stmt->execute();

        if($exec) {
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        }

        return $result;
    }
}