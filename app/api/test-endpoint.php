<?php
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405); 
    exit;
}

$response = ['status' => 'success', 'message' => 'API test is succesfull.'];
echo json_encode($response);
