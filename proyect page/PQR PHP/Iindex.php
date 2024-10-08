<?php



require 'config/database.php';


//1.conectar base de datos
$DB=connectarDB();

//1a. varible 
$consulta_table_depto= "selection * from departamento";
$resultado_table_depto= mysqli_query($DB,$consulta_table_depto);

//2.creacion e inicializados Variables
$clienteExiste = "0";

$emil='';
$nombre='';
$iddepto=0;
$nombreempleado='';
$mensaje='';
$fecha='';

 //DECLARANDO ARREGLO VACIO DE ERRORES
 $errores = [];

 // aqui comienza el action, cuando el usuario da click 
if( $_SERVER['REQUEST_METHOD'] ==='POST' )
 {
   $email = $_POST['email'];
   $nombre = $_POST['nombre'];

   $iddepto = (int)$_POST['iddepto'];
   $mensaje = $_POST['mensaje'];
   $fecha = date("Y-m-d h:i:s");


   if(!$email) 
   {
       $errores [] = "Ingresa un correo Electrónico";
   } 


   if(!$nombre) 
   {
       $errores [] = "Ingresa un tu nombre";
   }

   if($iddepto === 0) 
   {
       $errores [] = "selecciona un departamento";
   }

   if(!$mensaje) {
       $errores [] = "debe redactar un mensaje";
   }
   if(empty($errores));
    //5.4.2 cont
    $consulta_Cliente="SELECT email from cliente where 
    email='$email'";
    if($resultado_existeCliente=== 0){
        //5-4 VALIDANDO SI EL CLIENTE INGTERSTADO = TRUE
        $queryCliente ="insert into clientes (email,nombre) values ('$email','$nombre')";
        $resultado_Cliente=mysqli_query($DB,$queryCliente);


        if(resultado_Cliente){
            //5.4 VARIABLE DE CONTROL PARA MENSAJE DE BIENVENIDA
            $clienteExiste="1";
            echo "ahora usted ingreso a nuestra base de datos";
        }else
            echo "Lo siento, en este momento no se pudo hacer el registro";
        

    }

 }


//REQUIRIENDO EL CODIGO html DEL header---------------
require 'include/header.php';

?>

<h1 class="encabezado-principal">FORMULARIO DE CONTACTO</h1>
    <div class="contenedor contenido-form">
        <form class="formulario" method="POST" action="index.php">
        
        <?php foreach( $errores as $error ): ?>
            <div class="alerta-error">
                <?php echo $error; ?>
            </div>
        <?php endforeach; ?>

            <fieldset>
                <legend>informacion Personal</legend>

                <label for="nombre">Nombre</label>
                <input type="text" placeholder="tu Nombre" id="nombre" 
                name="nombre" value="<?php echo $nombre; ?>">

                <label for="nombre">Correo Electrónico</label>
                <input type="email" placeholder="tu Email" id="email" name="email"  value="<?php echo $email; ?>">
            </fieldset>

            <fieldset>
                <legend>Informacion remitida</legend>

                <label for="iddepto">Departamento que recibe </label>
                <select id="iddepto" name="iddepto"  value="">


                <label for="mensaje">Mensaje</label>
                <textarea id="mensaje" name="mensaje"><?php echo $mensaje; ?></textarea>

                    <option value="0">--seleccione--</option>

                    <?php
                        while($row= mysqli_fetch_assoc($resultado_table_depto)):


                    ?>

                    <option <?php echo $iddepto == $row['iddepto'] ? 'selected' : ''; ?> 
                        value="<?php echo $row['iddepto'];?>">
                        <?php echo $row['nombre depto']; ?>
                    </option>

                    </select>

                    <label for="mensaje">Mensaje</label>
                    <textarea id="mensaje" name="mensaje"><?php echo $mensaje; ?></textarea>

        </fieldset>


        <input class="boton" type="submit" value="Enviar">
        </form>    
    </div>           

<?php
//REQUIRIENDO EL CODIGO html DEL footer---------------
require 'include/footer.php';
?>