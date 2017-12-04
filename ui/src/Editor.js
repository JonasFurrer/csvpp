import React, {Component} from 'react';

class Editor extends Component {
    render() {
        return <div className="Editor field">
            <label className="label">{this.props.label}</label>

            <div className="control">
                    <textarea className="textarea"
                              onChange={this.props.onChange}
                              defaultValue={this.props.value}/>
            </div>
        </div>
    }
}


export default Editor;