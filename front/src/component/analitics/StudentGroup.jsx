import React, { useEffect, useRef, useState } from 'react';
import { Bar } from "react-chartjs-2";
import Chart from 'chart.js/auto';
// import * as d3 from 'd3';

function StudentGroup(){
    const [x, setX] = useState([]);
    const chartRef = useRef(null);
    const [subject, setSubject] = useState([]);
    const [selectedSubject, setSelectedSubject] = useState(1);
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
        fetch("http://localhost:8080/briefing/getAllProfiles", {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setProfile(data))
        .catch((e)=> console.log(e.message))
    }, [])

    const data = profile.map(item => {
      console.log(item)
      return(
        {
          data: (mark.filter(m => m.id_profile == item.id)).map(s => s.answer_mark),
          label: item.title,
          backgroundColor: "rgba(0, 0, "+ item.id*100 +", 0.5)",
          fill: true
        }
      )
    })
    console.log(data)

    const barChartData = {
      labels: x.map((item) => "Тема "+ item.number + ": "  + item.title),
      datasets: data
    };
  
    const barChart = (
      <Bar
        type="bar"
        width={130}
        height={50}
        options={{
          title: {
            display: true,
            text: "COVID-19 Cases of Last 3 Months",
            fontSize: 15
          },
          legend: {
            display: true, //Is the legend shown?
            position: "top" //Position of the legend.
          }
        }}
        data={barChartData}
      />
    );

    return(
        <div className='studentGroup'>
            <div className="line">
                <h2>Сравнение результатов летучек разных групп студентов</h2>
                <div></div>
            </div>
            <div className="form">
                <div className="subject">
                    <p>Предмет</p>
                    <select className='short' name="subject" onChange = {e => setSelectedSubject(e.target.value)} >
                    <option value=""></option>
                    {subject.map((item, index) => 
                        <option value = {item.id} key = {index} >{item.title}</option>
                    )}
                </select>
                </div>
                <div className="year">
                    <p>Год</p>
                    <input className='short' type="number" name="year" min='2000' max={new Date().getFullYear()} onChange={e => setYear(e.target.value)}/>
                </div>
            </div>
            {barChart}
        </div>
    )
}

export default StudentGroup;