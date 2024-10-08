<?php

function connectarDB():mysqli{

    $DB= mysqli_connect('localhost','root','091159Eliza*',
    'pqrs230831');

    if(!$$DB){

        echo ">Error: No se pudo conectar";
        exit;
    }else{

        return $$DB;

    }


}

?>