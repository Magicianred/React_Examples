# Portal

Servono a renderizzare dei componenti all'esterno dell'elemento radice dell'app react

```html
<div id="root"><!-- questa è il nodo radice dell'app react --></div>
<div id="modale"><!-- questo è il nodo dove vogliamo sia visualizzato il componente --></div>
```

```javascript
return ReactDOM.createPortal(
    <div><h1>Modale</h1><p>testo della modale</p></div>
    , document.getElementById('modale')
    )
)
```