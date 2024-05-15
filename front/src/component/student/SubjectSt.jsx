import { useContext, useState, useEffect } from "react";

function SubjectSt(){
    const subject = localStorage.getItem('subject');
    localStorage.removeItem('subject');
    const [listBr, setListBr]= useState([]);

    useEffect(() => {
        fetch("http://localhost:8080/getSubjects/1", {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setListBr(data))
        .catch((e)=> console.log(e.message))
    }, [])

    function getColor(status){
        if(status == 'Открыто') return 'blue';
        return 'red';

    }
  
      return (
        <>
        <div className="header_pr">
            <p className="title_pr">{subject} </p>
        </div>
        <div className="table-container">
          <table>
            <thead>
              <tr className="subject_tr">
                <th>Тема</th>
                <td>Лучший результат</td>
                <td>Попыток осталось</td>
                <td>Статус</td>
              </tr>
            </thead>
            <tbody>
              {listBr.map((item, index) => (
                <tr key={index}>
                  <th>{item.title}</th>
                  <td>{item.result}</td>
                  <td>{item.attempts}</td>
                  <td className={"prosent " + (getColor(item.status))}>{item.status}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        </>
      );
    }

export default SubjectSt;