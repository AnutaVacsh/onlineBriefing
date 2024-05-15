import { useContext, useState, useEffect } from "react";
import { StateTeacherContext } from "../../context/StateTeacherContext ";

function ListBriefingT(){
    let {state, setState} = useContext(StateTeacherContext);
    const [listBr, setListBr] = useState([]);
    console.log(listBr)

    useEffect(() => {
        fetch("http://localhost:8080/briefing/getSubjectsByTeacher/"+sessionStorage.getItem('idUser'), {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setListBr(data))
        .catch((e)=> console.log(e.message))
    }, [])

    function openBriefing(id){
        console.log({idSubject: id, idBriefing: null})
        // setState({idSubject: id, idBriefing: null})
        sessionStorage.setItem('idSubjectTeacher', id);
        window.location.href = "/teacher/briefing"
    }

    const elBr = listBr.map((item)=> {
        return <div className="elBriefing" key = {item.id} onClick={(e) => openBriefing(item.id)}>
            <p className="title">{item.title}</p>
        </div>
        }
    )

    return(
        <div className="briefingT">
            <div className="search"></div>
            <div className="listBriefing">
                {elBr}
            </div>
        </div>
    )
}

export default ListBriefingT;