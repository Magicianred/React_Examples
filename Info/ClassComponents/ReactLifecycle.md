# React Lifecycle  

## Lifecyle Phases  
* [Mounting](#mounting)  
    * [constructor](#constructor)  
    * [getDerivedStateFromProps](#getDerivedStateFromProps)  
    * [render](#render)  
    * [componentDidMount](#componentDidMount)  
* [Updating](#updating)  
    * [getDerivedStateFromProps](#getDerivedStateFromProps)
    * [shouldComponentUpdate](#shouldComponentUpdate)
    * [render](#render)
    * [getSnapshotBeforeUpdate](#getSnapshotBeforeUpdate)
    * [componentDidUpdate](#componentDidUpdate)
* [Unmounting](#unmounting)  
    * [componentWillUnmount](#componentWillUnmount)

### Mounting  
*Mounting* significa "montare" (mettere, posizionare) gli elementi nel DOM  

#### constructor  
(optional)  
E' chiamato come primo elemento ed è il punto naturale dove inzializzare lo *state*  
Il costruttore è chiamato con le *props* come parametro e deve usare come prima cosa *super(props)*  

```javascript
class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "Pagina principale"};
  }
  render() {
    return (
      <h1>{this.state.title}</h1>
    );
  }
}

ReactDOM.render(<Header />, document.getElementById('root'));
```

#### getDerivedStateFromProps
(optional)  
E' chiamato prima di effettuare il rendering degli elementi nel DOM  
E' il posto naturale per settare lo *state* con le *props*  
Riceve lo *state* come parametro e ritorna un oggetto con lo *state* modificato  

```javascript
class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "Pagina Principale"};
  }
  static getDerivedStateFromProps(props, state) {
    return { title: props.pageTitle };
  }
  render() {
    return (
      <h1>{this.state.title}</h1>
    );
  }
}

ReactDOM.render(<Header pageTitle="Contatti"/>, document.getElementById('root'));
```

#### render  
(required)  
E' il metodo che si occupa di restituire l'HTML al DOM  

```javascript
class Header extends React.Component {
  render() {
    return (
      <h1>This is the content of the Header component</h1>
    );
  }
}

ReactDOM.render(<Header />, document.getElementById('root'));
```

#### componentDidMount
(optional)  
Il componentDidMount() è chiamato dopo il rendering del componente.  
Qui vanno messi gli statements che richiedono che il componente sia già stato piazzato nel DOM.  

```javascript
class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "Pagina principale"};
  }
  componentDidMount() {
    setTimeout(() => {
      this.setState({ title: "Il mio sito" })
    }, 1000)
  }
  render() {
    return (
      <h1>{this.state.title}</h1>
    );
  }
}

ReactDOM.render(<Header />, document.getElementById('root'));
```


### Updating  
Un componente è Updating quando lo *state* o le *props* subiscono un cambiamento.  

#### getDerivedStateFromProps  
(optional)  
E' il primo metodo che viene chiamato quando si riceve un aggiornamento.  
Questo è il posto naturale dove si setta lo stato in base al cambio delle *props*  

```javascript
class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "La casetta in canadà" };
  }
  static getDerivedStateFromProps(props, state) {
    return { title: props.pageTitle };
  }
  changeTitle = () => {
    this.setState({ title: "Home page"});
  }
  render() {
    return (
      <div>
      <h1>{this.state.title}</h1>
      <button type="button" onClick={this.changeTitle}>Change page title</button>
      </div>
    );
  }
}

ReactDOM.render(<Header pageTitle="Titolo pagina"/>, document.getElementById('root'));
```

#### shouldComponentUpdate  
(optional)  
Nel metodo shouldComponentUpdate puoi ritornare un booleano che specifica quando React deve continuare col rendering e quando no.  
Il valore di default è *true*

```javascript
class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "Il blog di React"};
  }
  shouldComponentUpdate() {
    return false;
  }
  changeTitle = () => {
    this.setState({ title: "Il blog di Angular" });
  }
  render() {
    return (
      <div>
      <h1>{this.state.title}</h1>
      <button type="button" onClick={this.changeTitle}>Change page title</button>
      </div>
    );
  }
}

ReactDOM.render(<Header />, document.getElementById('root'));
```

#### render  
(required)  
riaggiorna il DOM a seguito dei cambiamenti allo *state* e alle *props*  

#### getSnapshotBeforeUpdate  
(optional)  
In questo metodo tu puoi avere accesso allo *state* e alle *props* prima dell'update, ossia puoi verificare qual'era il valore prima dell'update.  
Se è presente il metodo *getSnapshotBeforeUpdate* deve essere presente anche il metodo *componentDidUpdate*, altrimenti riceverai un errore.  

```javascript
class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "red" };
  }
  componentDidMount() {
    setTimeout(() => {
      this.setState({ title: "yellow" })
    }, 1000)
  }
  getSnapshotBeforeUpdate(prevProps, prevState) {
    document.getElementById("div1").innerHTML =
    "Prima il valore era: " + prevState.title;
  }
  componentDidUpdate() {
    document.getElementById("div2").innerHTML =
    "Dopo il valore è: " + this.state.title;
  }
  render() {
    return (
      <div>
        <h1>{this.state.title}</h1>
        <div id="div1"></div>
        <div id="div2"></div>
      </div>
    );
  }
}

ReactDOM.render(<Header />, document.getElementById('root'));
```

#### componentDidUpdate  
(optional, richiesto se usi *getSnapshotBeforeUpdate*)  
Il metodo è chiamato dopo che il DOM è stato aggiornato.    

```javascript
class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "Titolo" };
  }
  componentDidMount() {
    setTimeout(() => {
      this.setState({ title: "TItolo Pagina" })
    }, 1000)
  }
  componentDidUpdate() {
    document.getElementById("mydiv").innerHTML =
    "Il valore aggiornato è " + this.state.title;
  }
  render() {
    return (
      <div>
      <h1>{this.state.title}</h1>
      <div id="mydiv"></div>
      </div>
    );
  }
}

ReactDOM.render(<Header />, document.getElementById('root'));
```

### Unmonting  
La fase *unmonting* è chiamata quando un componente è rimosso dal DOM.  

#### componentWillUnmount  
(optional)  
viene chiamato quando un componente sarà rimosso dal DOM  

```javascript
class Container extends React.Component {
  constructor(props) {
    super(props);
    this.state = {show: true};
  }
  delHeader = () => {
    this.setState({show: false});
  }
  render() {
    let myheader;
    if (this.state.show) {
      myheader = <Child />;
    };
    return (
      <div>
      {myheader}
      <button type="button" onClick={this.delHeader}>Delete Header</button>
      </div>
    );
  }
}

class Child extends React.Component {
  componentWillUnmount() {
    alert("The component named Header is about to be unmounted.");
  }
  render() {
    return (
      <h1>Hello World!</h1>
    );
  }
}

ReactDOM.render(<Container />, document.getElementById('root'));
```
