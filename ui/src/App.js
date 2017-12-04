import React, {Component} from 'react';
import Editor from './Editor'
import 'font-awesome/css/font-awesome.min.css';
import 'bulma/css/bulma.css';
import './App.css';

class App extends Component {
    constructor(props) {
        super(props);

        this.state = {
            input: "",
            format: "",
            output: ""
        };
    }

    handleChange() {
        const input = document.querySelector(".csvpp-input textarea").value;
        const format = document.querySelector(".csvpp-format textarea").value;

        if (input.length === 0 && format.length === 0) {
            this.setState({output: ''});
            return;
        }

        this.setState({output: 'hello there'});
    }

    render() {
        return <div className="App section">
            <div className="container is-fluid">
                <h1 className="title">CSV++</h1>

                <div className="columns">
                    <div className="column csvpp-input">
                        <Editor value={this.state.input} label="Input" onChange={this.handleChange.bind(this)}/>
                    </div>
                </div>

                <div className="columns">
                    <div className="column csvpp-format">
                        <Editor value={this.state.format} label="Format" onChange={this.handleChange.bind(this)}/>
                    </div>

                    <div className="column csvpp-output">
                        <div className="field">
                            <label className="label">Output</label>

                            <div className="control">
                                <textarea className="textarea" value={this.state.output} readOnly/>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>;
    }
}

export default App;