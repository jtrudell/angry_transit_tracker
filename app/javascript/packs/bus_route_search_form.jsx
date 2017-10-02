import React from 'react'
import ReactDOM from 'react-dom'

class BusRouteSearchForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      busRouteValue: this.props.busRoutes[0].id
    }
    this.handleChange = this.handleChange.bind(this)
  }

  handleChange(event) {
    this.setState({busRouteValue: event.target.value})
  }

  render() {
    return(
      <div className="bus-form">
        <h1>Find your bus</h1>
        <select value={this.state.busRouteValue} onChange={this.handleChange}>
          {
            this.props.busRoutes.map((busRoute) => {
              return <option value={busRoute.id} key={busRoute.id}>{busRoute.external_id} - {busRoute.name}</option>
            })
          }
        </select>
        <a className="btn btn-primary" href={'/bus_routes/' + this.state.busRouteValue}>
          BAM!
        </a>
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('app')
  const data = JSON.parse(node.getAttribute('data'))

  ReactDOM.render(
    <BusRouteSearchForm busRoutes={data}/>,
    document.getElementById('app')
  )
})
