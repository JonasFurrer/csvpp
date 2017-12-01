import React, { Component } from 'react';
import 'font-awesome/css/font-awesome.min.css';
import 'bulma/css/bulma.css';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App section">
        <div className="container is-fluid">
          <h1 className="title">CSV++</h1>

          <div className="columns">
            <div className="column csvpp-input">
              <div className="field">
                <label className="label">Input</label>

                <div className="control">
                  <textarea className="textarea" placeholder=""></textarea>
                </div>
              </div>
            </div>
          </div>

          <div className="columns">
            <div className="column csvpp-format">
              <div className="field">
                <label className="label">Format</label>

                <div className="control">
                  <textarea className="textarea" placeholder="" rows="20"></textarea>
                </div>
              </div>
            </div>


            <div className="column csvpp-output">
              <div className="field">
                <label className="label">Output</label>

                <div className="control">
                  <textarea className="textarea" placeholder="" rows="20"></textarea>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>
    );
  }
}

export default App;
