import React, {Component} from 'react';

class Editor extends Component {
  render() {
    return <div className="Editor field">
      <label className="label">{this.props.label}</label>

      <div className="control">
                    <textarea className="textarea"
                              rows={this.props.rows}
                              placeholder={this.props.placeholder}
                              onChange={this.props.onChange}
                              defaultValue={this.props.value}/>
      </div>
    </div>
  }
}


export default Editor;