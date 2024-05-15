import { useState } from "react";

function UntestedStudent(){
    const [student, setStudent] = useState([]);

    function openStudent(id, name){
        sessionStorage.setItem('selectedStudentId', id);
        sessionStorage.setItem('selectedStudentName', name);
        window.location.href = "/teacher/check/untestedBriefing/stud/test"
        
    }

    const elSt = student.map((item)=> {
        return <div className="elStudent" key = {item.id} onClick={(e) => openStudent(item.id, item.surname +" "+ item.name+" "+ item.patronymic)}>
            <p className="name">{item.surname +" "+ item.name+" "+ item.patronymic}</p>
        </div>
        }
    )

    return(
        <div className="untestedStudent">
            <div className="listStudens">
                {elSt}
            </div>
        </div>
    )
}

export default UntestedStudent;