# Nube_semana2_tarea1.0

Instrucciones

En este entregable desarrollarás una aplicación usando Xcode que después de haber realizado una petición a https://openlibrary.org/ (entregable anterior) analice os datos JSON obtenidos y los presente de manera adecuada

Para ello deberás crear una interfaz de usuario, usando la herramienta Storyboard que contenga:

1. Una caja de texto para capturar el ISBN del libro a buscar

2. EL botón de "enter" del teclado del dispositivo deberá ser del tipo de búsqueda ("Search")

3. El botón de limpiar ("clear") deberá estar siempre presente

4. En la vista deberás poner elementos para mostrar:

- El título del libro
- Los autores (recuerda que está en plural, pueden ser varios)
- La portada del libro (en caso de que exista)

Un ejemplo de URL para acceder a un libro es:
https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7

Su programa deberá sustituir el último código de la URL anterior (en este caso 978-84-376-0494-7) por lo que se ponga en la caja de texto

Al momento de presionar buscar en el teclado, la vista deberá mostrar los datos anteriormente descritos en concordancia con el ISBN que se ingreso en la caja de texto

En caso de error (problemas con Internet), se deberá mostrar una alerta indicando esta situación
