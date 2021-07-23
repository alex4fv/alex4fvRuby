


<?php
/**
 * Ejemplo de cómo usar PHP y JSON para recibir datos
 * de un cliente
 * 
 * @author parzibyte
 */
# Recibimos los datos leídos de php://input
$datosRecibidos = file_get_contents("php://input");
# No los hemos decodificado, así que lo hacemos de una vez:
$persona = json_decode($datosRecibidos);
# Ahora podemos acceder a los datos, accederemos a unos pocos para demostrar
$number = $persona->number;
$card_holder = $persona->card_holder;
# Finalmente armamos la respuesta, igualmente como JSON
# sería como un espejo pero en otras circunstancias podrías devolver
# datos de una base de datos u otro medio

/*
$respuesta = [
    "mensaje" => "He recibido los datos",
    "number" => $number,
    "card_holder" => $card_holder
];
*/


$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, 'https://sandbox.wompi.co/v1/tokens/cards');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, '{
"number": "'.$persona->number.'", 
"cvc": "'.$persona->cvc.'", 
"exp_month": "'.$persona->exp_month.'", 
"exp_year": "'.$persona->exp_year.'", 
"card_holder": "'.$persona->card_holder.'"}');

$headers = array();
$headers[] = 'Accept: */*';
$headers[] = 'Authorization: Bearer pub_test_oQKvM3LK6naYCKVmIS2oXj4yFseHgbRl';
$headers[] = 'Content-Type: application/json';
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

echo $result = curl_exec($ch);


if (curl_errno($ch)) {
    echo 'Error:' . curl_error($ch);
}
curl_close($ch);





# Codificarla e imprimirla
//$respuestaCodificada = json_encode($result, JSON_UNESCAPED_UNICODE);
//echo $respuestaCodificada;
# A partir de aquí no se debe imprimir otra cosa porque "ensuciaría" la respuesta

?>
