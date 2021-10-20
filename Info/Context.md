# Context

Il componente wrapper

```javascript
const ThemeContext = React.createContext({ defaultValue: 'light' });

const toggleTheme = () => this.state.defaultValue === 'light' ? 'dark' : 'light' ;

render() {
    return (
        <div>
            <ThemeContext.Provider value={{ value: this.state.defaultValue, update: toggleTheme }>
                <Component1 />
                <Component2>
                    <Component3 />
                </Component2>
            </ThemeContext.Provider>
        </div>
    )
}
```

Il componente che utilizza il Context

```javascript
function AppButton(props, context) {
    const themeClass = context === 'light' ? 'is-light' : 'is-dark';

    ...
}
```

Per aggiornare il Context, considerando *value* e *update* una proprietà ed una funzione che sono state inserite nel *value* di ThemeContext.Provider
```javascript
return 
<ThemeContext.Consumer>
    {({ value, update }) => {
        <Component1 theme="value" />
        <Component2 />
        <Button onClick={update} />
    }}
</ThemeContext.Consumer>
```

Uso dell'hook al posto del Consumer
```javascript

const theme = useContext(ThemeContext);

const renderButton = () => <Button className={theme.value} onClick={theme.update}>
```