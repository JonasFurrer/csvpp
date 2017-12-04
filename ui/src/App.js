import React, {Component} from 'react';
import Editor from './Editor';
import axios from 'axios';

import 'font-awesome/css/font-awesome.min.css';
import 'bulma/css/bulma.css';
import './App.css';

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      input: "",
      inputPlaceHolder: "RE|71294495|0|1173140|1|0|0|4|99|99|1|20150112|20150112||0\n" +
      "RE|71294495|0|1173140|1|0|0|4|99|99|1|20150112|20150112||0|20150113|7|7|1|7|3|6|6|7|5|5|1|3|1|6|6|7|6|7\n",
      format: "",
      formatPlaceHolder: "{\n" +
      "  \"vars\": {\n" +
      "    \"v1\": {\n" +
      "      \"position\": 1,\n" +
      "      \"type\": \"int\"\n" +
      "    },\n" +
      "    \"v2\": {\n" +
      "      \"position\": 2,\n" +
      "      \"type\": \"string\"\n" +
      "    }\n" +
      "  }\n" +
      "}\n",
      output: "",
      outputClass: ""
    };
  }

  handleChange() {
    const input = document.querySelector(".csvpp-input textarea").value;
    const format = document.querySelector(".csvpp-format textarea").value;

    if (input.length === 0 || format.length === 0) {
      this.setState({output: '', outputClass: ''});
      return;
    }

    axios.post('http://localhost:9292/parse', {
      input: input,
      format: format
    })
      .then((response) => {
        const output = JSON.stringify(response.data, null, 2);
        this.setState({output: output, outputClass: 'is-success'});
      });
  }

  render() {
    return <div className="App section">
      <div className="container is-fluid">
        <h1 className="title">CSV++</h1>

        <div className="field is-grouped is-grouped-multiline csvpp-options">
          <div className="control">
            <div className="tags has-addons">
              <span className="tag is-dark">Separator</span>
              <a className="tag is-link">|</a>
            </div>
          </div>

          <div className="control">
            <div className="tags has-addons">
              <span className="tag is-dark">Conversions</span>
              <a className="tag is-success">On</a>
            </div>
          </div>
        </div>

        <div className="columns">
          <div className="column csvpp-input">
            <Editor value={this.state.input} label="Input" onChange={this.handleChange.bind(this)}
                    placeholder={this.state.inputPlaceHolder}/>
          </div>
        </div>

        <div className="columns">
          <div className="column csvpp-format">
            <Editor value={this.state.format} label="Format" onChange={this.handleChange.bind(this)} rows={15}
                    placeholder={this.state.formatPlaceHolder}/>
          </div>

          <div className="column csvpp-output">
            <div className="field">
              <label className="label">Output</label>

              <div className="control">
                <textarea className={this.state.outputClass + " textarea"} value={this.state.output} rows="15"
                          readOnly/>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>;
  }
}

export default App;