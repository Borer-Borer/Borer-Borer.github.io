# 浅义理解React


## State & 生命周期 & 执行顺序

#### 执行顺序
```
class Test extends React.Component {
    constructor(props) {
        super(props);
        this.state = { date: new Date() };
    }
    componentDidMount() {
        this.timerId = setInterval(() => this.tick(), 1000);
    }
    componentWillUnmount() {
        clearInterval(this.timerId);
    }
    tick() {
        this.setState({ date: new Date() });
    }
    render() {
        return (
            <div>
                <h1>Hello,world!</h1>
                <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
            </div>
        );
    }
}

ReactDOM.render(<Test />, document.getElementById('root'));
```
- `ReactDom.render`===>`Test.constructor`====>`Test.render`==Test的输出被插入到DOM之后==>`Test.ComponentDidMount`====>`Test.tick`====>`setState`==state改变则重新调用`Test.render`确定页面上该显示什么，React重新更新DOM==一旦`Test`组件从DOM中移除===>`Test.componentWillUnmount`.
- React生命周期方法:
- setState:


