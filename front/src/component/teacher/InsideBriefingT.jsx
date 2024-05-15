import '../../css/briefing.css'
import { useState, useEffect, useContext } from 'react'
import { StateTeacherContext } from '../../context/StateTeacherContext ';
import RenderInsideBriefingT from './RenderInsideBriefingT'

function InsideBriefingT(){
    const [subject, setSubject] = useState();
    const [briefing, setBriefing] = useState();
    const [profile, setProfile] = useState([]);
    const [group, setGroup] = useState([]);

    const [selectedProfile, setsSelectedProfile] = useState({});
    const [selectedGroup, setSelectedGroup] = useState({});

    const data = {
        year: "",
        profile: "",
        group: ""
    };

    useEffect(() => {
        fetch("http://localhost:8080/briefing/getSubject/"+subject.id, {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setSubject(data))
        .catch((e)=> console.log(e.message))
    }, [])

    useEffect(() => {
        fetch("http://localhost:8080/briefing/getBriefing/"+briefing.id, {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setBriefing(data))
        .catch((e)=> console.log(e.message))
    }, [])


    return(
        <div className="InsideBriefing">
            <h2>{subject.title}</h2>
            <div className="line">
                <h2>{"Тема "+ briefing.number + ": "  + briefing.title}</h2>
                <div></div>
            </div>

            <RenderInsideBriefingT subject = {subject} briefing = {briefing}/>
        </div>
    )
}

export default InsideBriefingT;