// Obtener la información del producto seleccionado
fetch('productos.json')
  .then(response => response.json())
  .then(data => {
    const productoId = parseInt(window.location.search.split('=')[1]);
    const producto = data.productos.find(producto => producto.id === productoId);

    // Mostrar la información del producto
    document.getElementById('producto-imagen').src = producto.imagen;
    document.getElementById('producto-nombre').textContent = producto.nombre;
    document.getElementById('producto-descripcion').textContent = producto.descripcion;
    document.getElementById('producto-precio').textContent = producto.precio;

    // Mostrar las opciones del producto
    const colorSelect = document.getElementById('color');
    const tallaSelect = document.getElementById('talla');

    producto.colores.forEach(color => {
      const option = document.createElement('option');
      option.value = color;
      option.text = color;
      colorSelect.appendChild(option);
    });

    producto.tallas.forEach(talla => {
      const option = document.createElement('option');
      option.value = talla;
      option.text = talla;
      tallaSelect.appendChild(option);
    });
  })
  .catch(error => console.error('Error al obtener la información del producto:', error));
