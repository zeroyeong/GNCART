let date=new Date();
let nowYear=date.getFullYear();

document.getElementById('calYear').innerText=nowYear;
document.getElementById('prevYear').innerText=nowYear-1;
document.getElementById('nextYear').innerText=nowYear+1;

function prevYear(){
  nowYear-=1;
  document.getElementById('calYear').innerText=nowYear;
  document.getElementById('prevYear').innerText=nowYear-1;
  document.getElementById('nextYear').innerText=nowYear+1;
}

function nextYear(){
  nowYear+=1;
  document.getElementById('calYear').innerText=nowYear;
  document.getElementById('prevYear').innerText=nowYear-1;
  document.getElementById('nextYear').innerText=nowYear+1;
}