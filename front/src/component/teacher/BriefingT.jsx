import '../../css/briefing.css'
import { useState, useEffect, useContext } from 'react'
import { StateTeacherContext } from '../../context/StateTeacherContext ';

function BriefingT(){
    // let {state, setState} = useContext(StateTeacherContext);
    const [themes, setThemes] = useState([]);
    console.log(sessionStorage.getItem('idSubjectTeacher'));

    useEffect(() => {
        fetch("http://localhost:8080/briefing/getBriefings/"+ sessionStorage.getItem('idSubjectTeacher'), {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setThemes(data))
        .catch((e)=> console.log(e.message))
    }, [])

    function add(){
        window.location.href = "/teacher/briefing/add"
    }

    function openTheme(id){
        sessionStorage.setItem('idThemeTeacher', id);
        console.log(id)
        window.location.href = "/teacher/briefing/insideBriefing"
    }

    function changeState(id, status){
        fetch("http://localhost:8080/briefing/editState/"+id, {
            method: "PUT",
            headers: {"Content-Type":"application/json"},
            body: status == "открыто" ? "закрыто" : "открыто"
        })
        .then(()=>{console.log("edit state")})
        .catch((e)=> console.log(e.message));
    }

    const elT = themes.map((item)=> {
        return <div className="elThemes" key = {item.id} onClick={(e) => openTheme(item.id)}>
            <p className="title">{"Тема "+ item.number + ": "  + item.title}</p>
            <div>
                <p className={"status "+ (item.status.toLocaleLowerCase() == 'открыто' ? 'blue' : 'red')}>{item.status}</p>
                <p className={"changeState"} onClick={(e) => changeState(item.id, item.status.toLocaleLowerCase())}>{(item.status.toLocaleLowerCase() == 'открыто' ? 'Закрыть' : 'Открыть')}</p>
            </div>
        </div>
        }
    )

    return(
        <div className="briefing">
            <div className="addBriefing" onClick={add}>

            </div>
            <div className="listThemes">
                {elT}
            </div>
        </div>
    )
}

export default BriefingT;