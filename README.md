# Prueba
<h1> Funcionamiento </h1>
Se muestra una vista de loading creada con lottie hasta la carga de api, en caso de éxito se muestra la imágen y nombre de los personajes en un tableView, en caso de error se muestra una vista lottie de Morty llorando.
Existe la posibilidad de buscar por nombre del personaje implementado con un Search Bar.
Si paginas, al llegar a la última posición se vuelve a llamar a la api sumando 1 a la página (se muestra una animación lottie de loading que habría que estudiar si es mejor retirar ya que la mayoría de las ocasiones es tan rápido que no es necesario y puede empeorar la experiencia de usuario), hasta llegar a la página final.
Al seleccionar un personaje cambiamos al ViewController del detalle y se muestra: imágen, nombre, especie, localización, género y el número de episodios. 
<h1> Arquitectura </h1>
Se ha utilizado una arquitectura MVMM, he decidido crear un solo viewModel que realiza la llamada a la api.<br>
También se ha utilizado Combine.
<h1> CocoaPods </h1>
<li> Lottie: Animación loading </li>
<li> Kingfisher: Guardado y cacheo de imágenes </li>
<h1> Test </h1>
Se han realizado test unitarios de los ViewController y ViewModel generando un ApiMock y JSON de prueba.
