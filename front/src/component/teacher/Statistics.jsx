import { useState, useEffect } from "react";

function Statistics(){
    const [profile, setProfile] = useState([]);
    const [group, setGroup] = useState([]); //все группы для option
    const [student, setStudent] = useState([])
    const [idGroup, setIdGroup] = useState(); //id выбранной группы

    const [selectedYear, setsSelectedYear] = useState();
    const [selectedProfile, setsSelectedProfile] = useState();
    const [selectedCourse, setSelectedCourse] = useState();
    const [selectedGroup, setSelectedGroup] = useState();

    console.log(selectedYear, selectedGroup, selectedCourse, selectedProfile)

    useEffect(() => {
        fetch("http://localhost:8080/briefing/getAllProfiles", {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setProfile(data))
        .catch((e)=> console.log(e.message))
    }, [])

    useEffect(() => {
        fetch("http://localhost:8080/briefing/getAllGroups", {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setGroup(data))
        .catch((e)=> console.log(e.message))
    }, [])

    //группу id_profile year_begin number
    useEffect(() => {
        fetch("http://localhost:8080/briefing/findGroup/"+selectedProfile+"/"+selectedYear-selectedCourse+"/"+selectedGroup, {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setIdGroup(data))
        .catch((e)=> console.log(e.message))
    }, [])

    if(idGroup){
        //берём всех студентов этой группы
        fetch("http://localhost:8080/?/?/"+ idGroup, {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setStudent(data))
        .catch((e)=> console.log(e.message))
    }
    const elSt = student.map(item =>
    <div className='elStudent'>
        <p className='name'>{item.surname +" "+ item.name+" "+ item.patronymic}</p>
        {selectedProfile && selectedCourse && selectedGroup && <p className='group'>{profile.find(p => p.id == selectedProfile).title + " " + selectedCourse + group.find(p => p.id == selectedGroup).number}</p>}
        <p className='prosent'>{item.mark}</p>

    </div>
    )
    

    return(
        <div className='statistics'>
            <div className="line">
                <h2>Статистика </h2>
                <div></div>
            </div>
            <div className="form">
                <div className="profile">
                    <p>Профиль</p>
                    {/* <select className='short' name="profile" onChange = {e => {data.profile = e.target.value}} > */}
                    <select className='short' name="profile" onChange = {e => setsSelectedProfile(e.target.value)} >
                    <option value=""></option>
                    {profile.map((item, index) => 
                        <option value = {item.id} key = {index} >{item.title}</option>
                    )}
                </select>
                </div>
                <div className="course">
                    <p>Курс</p>
                    {/* <input className='short' type="number" name="course" min='1' max='5' onChange={e => {data.course = e.target.value}}/> */}
                    <input className='short' type="number" name="course" min='1' max='5' onChange={e => setSelectedCourse(e.target.value)}/>
                </div>
                <div className="group">
                    <p>Группа</p>
                    {/* <select className='short' name="group" onChange = {e => {data.group = e.target.value}} > */}
                    <select className='short' name="group" onChange = {e => setSelectedGroup(e.target.value)} >
                    <option value=""></option>
                    {group.map((item, index) => 
                        <option value = {item.id} key = {index} >{item.number}</option>
                    )}
                    </select>
                </div>
            </div>
            <div className='raiting'>
                {elSt}
            </div>
        </div>
    )
}

export default Statistics;