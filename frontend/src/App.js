import React, { useState } from 'react';
import './App.css';

function App() {
  const [target, setTarget] = useState('');
  const [results, setResults] = useState('');
  const [loading, setLoading] = useState(false);
  const [hackerMode, setHackerMode] = useState(true);

  const runScan = async () => {
    setLoading(true);
    try {
      const res = await fetch(`http://localhost:5000/scan?target=${target}`);
      const data = await res.json();
      setResults(data.output);
    } catch (err) {
      setResults(`Error: ${err.message}`);
    }
    setLoading(false);
  };

  const copyOutput = () => {
    navigator.clipboard.writeText(results);
    alert("Output copied to clipboard!");
  };

  return (
    <div className={`App ${hackerMode ? 'hacker' : ''}`}>
      <h1>Vulnerability Scanner</h1>

      <div className="controls">
        <input
          type="text"
          placeholder="Enter IP or domain"
          value={target}
          onChange={(e) => setTarget(e.target.value)}
        />
        <button onClick={runScan} disabled={loading}>
          {loading ? 'Scanning...' : 'Run Scan'}
        </button>
        <button onClick={copyOutput} disabled={!results}>Copy Output</button>
        <button onClick={() => setHackerMode(!hackerMode)}>
          {hackerMode ? 'Normal Mode' : 'Hacker Mode'}
        </button>
      </div>

      <pre className="output">{results}</pre>
    </div>
  );
}

export default App;
