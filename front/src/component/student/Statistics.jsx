import {useState, useEffect } from "react";

function Statistics(){
    //const [myData, setMyData] = useState([{place: 4, prosent: 80}]);
    const [myData, setMyData] = useState([]);
    //const [bestData, setBestData] = useState([{place: 15, prosent: 96}]);
    const [bestData, setBestData] = useState([]);
    const [subjects, setSubjects] = useState([]); // Список предметов
    const [selectedSubject, setSelectedSubject] = useState(''); // Выбранный предмет

    useEffect(() => {
        // Выполняем GET-запрос для получения списка предметов
        fetch('http://localhost:8080/briefing/getSubjects/1')
          .then(response => {
            if (!response.ok) {
              throw new Error('Ошибка сети');
            }
            return response.json();
          })
          .then(data => {
            setSubjects(data);
          })
          .catch(error => {
            console.error('Ошибка при получении данных:', error);
          });


        fetch('http://localhost:8080/briefing/averageGrade/1/'+selectedSubject)
          .then(response => {
            if (!response.ok) {
              throw new Error('Ошибка сети');
            }
            return response.json();
          })
          .then(data => {
            setMyData(data);
          })
          .catch(error => {
            console.error('Ошибка при получении данных:', error);
          });
    
 
        fetch('http://localhost:8080/briefing/getRating/1/'+selectedSubject)
          .then(response => {
            if (!response.ok) {
              throw new Error('Ошибка сети');
            }
            return response.json();
          })
          .then(data => {
            setBestData(data);
          })
          .catch(error => {
            console.error('Ошибка при получении данных:', error);
          });
      }, []); 

    // Функция обработки изменения выбранного предмета
    const handleSubjectChange = (event) => {
        setSelectedSubject(event.target.value);
    };

    const elMy = myData.map((item)=> (
        <div className="elStatic" key={item.place}>
            <p className="title_th">{'Мой процент: '+item.prosent}</p>
            <p className="title_th">{'Мое место: '+item.place}</p>
        </div>
    ));

    const elBest = bestData.map((item)=> (
        <div className="elStatic" key={item.place}>
            <p className="title_th">{'Лучший процент: '+item.prosent}</p>
            <p className="title_th">{'Всего мест: '+item.place}</p>
        </div>
    ));

    return(
        <div className="briefing">
            <div className="header_pr">
                <p className="title_pr">Статистика </p>
                <hr className="line" />
            </div>
            <div>
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
                {elMy}
                {elBest}
            </div>
        </div>
    )
}

export default Statistics;
