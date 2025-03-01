// import Chart from 'chart.js'
import Chart from 'chart.js/auto'

document.addEventListener('DOMContentLoaded', function () {
  const ctx = document.getElementById('swotChart')

  if (ctx) {
    const swotData = {
      labels: ['Strengths', 'Weaknesses', 'Opportunities', 'Threats'],
      datasets: [
        {
          label: 'SWOT Analysis',
          data: [
            document.getElementById('strengths').textContent.length,
            document.getElementById('weaknesses').textContent.length,
            document.getElementById('opportunities').textContent.length,
            document.getElementById('threats').textContent.length,
          ],
          backgroundColor: [
            'rgba(75, 192, 192, 0.6)', // Strengths (Green)
            'rgba(255, 99, 132, 0.6)', // Weaknesses (Red)
            'rgba(54, 162, 235, 0.6)', // Opportunities (Blue)
            'rgba(255, 206, 86, 0.6)', // Threats (Yellow)
          ],
          borderColor: [
            'rgba(75, 192, 192, 1)',
            'rgba(255, 99, 132, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(255, 206, 86, 1)',
          ],
          borderWidth: 1,
        },
      ],
    }

    new Chart(ctx, {
      type: 'bar', // You can change this to 'pie' or 'radar'
      data: swotData,
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true,
          },
        },
      },
    })
  }
})
