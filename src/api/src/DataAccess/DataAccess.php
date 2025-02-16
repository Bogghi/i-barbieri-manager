<?php

namespace App\DataAccess;

require_once 'src/controllers/BaseController.php';

use PDO;
use App\controllers\BaseController;

class DataAccess extends BaseController
{

    protected ?PDO $pdo = null;

    public function connectPdo(): void
    {
        if(!$this->pdo){
            $this->pdo = new PDO('mysql:host=' . DB_HOST . ';port=' . DB_PORT . ';dbname=' . DB_NAME . ';charset=utf8mb4', DB_USER, DB_PASSWORD);
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
            $this->status = 500;
            $this->error = $E->getMessage();
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
            $this->status = 500;
            $this->error = $E->getMessage();
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
            $this->status = 500;
            $this->error = $E->getMessage();
        }

        return $result;
    }

    public function update(string $table, ?array $args = null, ?array $where = null): array
    {
        $this->connectPdo();

        $result = [];
        if(!$args){
            return $result;
        }

        $base = "UPDATE $table SET ";
        $cols = [];
        $params = [];

        foreach ($args as $col => $val) {
            $cols[] = "$col = ?";
            $params[] = $val;
        }

        $wherePart = '';
        if($where && is_array($where)) {
            $columns = [];
            $values = [];
            foreach ($where as $col => $arg) {
                $argStr = "$arg";
                $operator = in_array($argStr[0], ['>','<','!=','like']) ? $argStr[0] : '=';
                $columns[] = "$col $operator ?";
                $values[] = $operator !== '=' ? ltrim($argStr, '><!=like') : $argStr;
            }
            $wherePart = 'where '.implode(' and ', $columns);
            $params = array_merge($params, $values);
        }

        if($wherePart !== '') {
            try {
                $sql = $base . implode(',', $cols) . ' ' . $wherePart;
                $stmt = $this->pdo->prepare($sql);
                $exec = $stmt->execute($params);
                if ($exec) {
                    $result[] = $stmt->rowCount();
                }
            } catch (\PDOException $E) {
                $this->status = 500;
                $this->error = $E->getMessage();
            }
        }

        return $result;
    }

    protected function validateToken(string $token, string $type): bool
    {
        $valid = false;

        if($type === 'oauth') {
            $this->connectPdo();
            $tokenRow = $this->get('oauth_tokens', ['oauth_token' => $token, 'expire_date' => '<now()']);
            $valid = count($tokenRow) > 0;
        }
        if($type === 'refresh') {
            $this->connectPdo();
            $tokenRow = $this->get('refresh_tokens', ['refresh_token' => $token, 'expire_date' => '<now()']);
            $valid = count($tokenRow) > 0;
        }

        return $valid;
    }
}