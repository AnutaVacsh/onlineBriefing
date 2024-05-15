import React, { useEffect, useRef, useState } from 'react';
import Chart from 'chart.js/auto';

function Effectiveness(){
    const [x, setX] = useState([]);
    const chartRef = useRef(null);
    const [selectedSubject, setSelectedSubject] = useState(1);
    const [subject, setSubject] = useState([]);
    const [year, setYear] = useState();
    const [mark, setMark] = useState([]);
    const [profile, setProfile] = useState([]);

    if(selectedSubject){
            fetch("http://localhost:8080/briefing/getBriefings/"+selectedSubject, {
                mode: 'cors',
                method: 'GET',
            })
            .then(res => res.json())
            .then(data => setX(data))
            .catch((e)=> console.log(e.message))
      }

      useEffect(() => {
        fetch("http://localhost:8080/briefing/getSubjectsByTeacher/"+sessionStorage.getItem('idUser'), {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setSubject(data))
        .catch((e)=> console.log(e.message))
    }, [])

    useEffect(() => {
        fetch("http://localhost:8080/briefing/getProfile", {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setProfile(data))
        .catch((e)=> console.log(e.message))
    }, [])

    useEffect(() => {
        const ctx = chartRef.current.getContext('2d');

        const data = {
        labels: x.map((item) => "Тема "+ item.number + ": "  + item.title),
        datasets: [
            {
            label: '',
            data: mark.map(m => m.answer_mark),
            backgroundColor: '#001198',
            borderColor: 'rgba(75,192,192,1)',
            borderWidth: 1,
            },
        ],
    };

    new Chart(ctx, {
        type: 'bar',
        data: data,
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
        },
      });
    }, []); 

    return(
        <div className='studentGroup'>
            <div className="line">
                <h2>Оценка эффективности учебных программ</h2>
                <div></div>
            </div>
            <div className="form">
                <div className="subject">
                    <p>Предмет</p>
                    <select className='short' name="subject" onChange = {e => setSubject(e.target.value)} >
                    <option value=""></option>
                    {profile.map((item, index) => 
                        <option value = {item.id} key = {index} >{item.title}</option>
                    )}
                </select>
                </div>
                <div className="year">
                    <p>Год</p>
                    <input className='short' type="number" name="year" min='2000' max={new Date().getFullYear()} onChange={e => setYear(e.target.value)}/>
                </div>
            </div>
            <canvas className='diagramm' ref={chartRef} />
        </div>
    )

//   return <canvas ref={chartRef} />;
}

export default Effectiveness;