import {useState, useEffect, useRef } from "react";
import Chart from 'chart.js/auto';

function Progress(){
    
    const chartRef = useRef(null);
    const [chartData, setChartData] = useState([]);
    const [subjects, setSubjects] = useState([]); // Список предметов
    const [scoress, setScores] = useState([]);
    const [selectedSubject, setSelectedSubject] = useState(''); // Выбранный предмет


    useEffect(() => {
      fetch("http://localhost:8080/brifing/getSubjects/1", {
          mode: 'cors',
          method: 'GET',
      })
      .then(res => res.json())
      .then(data => setChartData(data))
      .catch((e)=> console.log(e.message))
  }, [])

    useEffect(() => {
      fetch("http://localhost:8080/brifing/getScores/1/"+selectedSubject, {
          mode: 'cors',
          method: 'GET',
      })
      .then(res => res.json())
      .then(data => setScores(data))
      .catch((e)=> console.log(e.message))
  }, [])

    useEffect(() => {
        const ctx = chartRef.current.getContext('2d');
        new Chart(ctx, {
        type: 'bar', 
        data: {
            labels: ['летучка1', 'летучка2', 'летучка3', 'летучка4'],
            datasets: [{
            label: '', 
            data: [65, 59, 80, 70] //charData
            }]
        },
        options: { 
            scales: { 
              x: { 
                type: 'category', 
              }, 
            }, 
            plugins: { 
              legend: { 
                display: false, 
              }, 
            }, 
          }
        });
    }, []);

    const handleSubjectChange = (event) => {
      setSelectedSubject(event.target.value);
  };
    
    return (
        <>
        <div className="header_pr">
            <p className="title_pr">Прогресс </p>
            <hr className="line" />
        </div>
        <p className="inputs">
                    Предмет 
                    <select
                        className="subjectInput"
                        value={selectedSubject}
                        onChange={handleSubjectChange}
                    >
                        
                        {subjects.map(subject => (
                            <option key={subject.id} value={subject.title}>{subject.title}</option>
                        ))}
                    </select>
                </p>
            
        <canvas className="diagr"  ref={chartRef} />
        </>
    ); 

}

export default Progress;
// import { useState, useEffect, useRef } from "react";
// import Chart from 'chart.js/auto';

// function Progress() {
//     const chartRef = useRef(null);
//     const [chartData, setChartData] = useState(null);

//     useEffect(() => {
//         const fetchData = async () => {
//             try {
//                 const response = await fetch('https://example.com/api/data');
//                 if (!response.ok) {
//                     throw new Error('Failed to fetch data');
//                 }
//                 const data = await response.json();
//                 setChartData(data);
//             } catch (error) {
//                 console.error('Error fetching data:', error);
//             }
//         };

//         fetchData();
//     }, []);

//     useEffect(() => {
//         if (chartData) {
//             const ctx = chartRef.current.getContext('2d');
//             new Chart(ctx, {
//                 type: 'bar',
//                 data: {
//                     labels: chartData.labels,
//                     datasets: [{
//                         label: '', 
//                         data: chartData.data 
//                     }]
//                 },
//                 options: { 
//                     scales: { 
//                         x: { 
//                             type: 'category', 
//                         }, 
//                     }, 
//                     plugins: { 
//                         legend: { 
//                             display: false, 
//                         }, 
//                     }, 
//                 }
//             });
//         }
//     }, [chartData]);

//     return (
//         <>
//             <div className="header_pr">
//                 <p className="title_pr">Прогресс </p>
//                 <hr className="line" />
//             </div>
                
//             <canvas className="diagr"  ref={chartRef} />
//         </>
//     );
// }

// export default Progress;
