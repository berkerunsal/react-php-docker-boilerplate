import github from './assets/github.svg'
import './App.css'
import TestEndpoint from './views/TestEndpoint'
function App() {

  return (
    <>
      <div className="card">
        <p>
          <TestEndpoint />
        </p>
      </div>
      <div>
        <a href="https://github.com/berkerunsal/react-php-docker-boilerplate" target="_blank">
          <img src={github} className="logo" />
        </a>
      </div>
    </>
  )
}

export default App
