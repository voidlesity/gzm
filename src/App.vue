<template>
  <div id="app">
    <div class="stars"></div>
    <div class="container">
      <h1>Working Time Calculator</h1>
      <div>
        <label for="startTime">Start Time:</label>
        <input type="time" @keyup.enter="calculateEndTime" v-model="startTime" />
      </div>
      <div>
        <label for="workHours">Work Hours:</label>
        <input type="number" @keyup.enter="calculateEndTime" v-model.number="workHours" />
      </div>
      <div>
        <label for="lunchBreak">Lunch Break Hours:</label>
        <input type="number" @keyup.enter="calculateEndTime" v-model.number="lunchBreak" />
      </div>
      <div>
        <label for="extraHours">Extra Hours:</label>
        <input type="number" step="0.01" @keyup.enter="calculateEndTime" v-model.number="extraHours" />
      </div>
      <button @click="calculateEndTime" @keyup.enter="calculateEndTime" :disabled="!startTime">Calculate End Time</button>

      <div v-if="endTime">
        <p>You can go home at: {{ endTime }}</p>
        <p>Time remaining: {{ timeRemaining }}</p>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'App',
  data() {
    return {
      startTime: '',
      workHours: 7.98,
      lunchBreak: 0.5,
      extraHours: 0,
      endTime: '',
      timeRemaining: '',
      windowSize: { width: window.innerWidth, height: window.innerHeight },
    };
  },
  computed: {
    totalHours() {
      return this.workHours + this.lunchBreak - this.extraHours;
    },
    endTimeDate() {
      const startTimeDate = new Date();
      startTimeDate.setHours(...this.startTime.split(':').map(Number), 0, 0);
      return new Date(startTimeDate.getTime() + this.totalHours * 60 * 60 * 1000);
    },
    timeRemainingComputed() {
      const now = new Date();
      if (now < this.endTimeDate) {
        const hoursRemaining = Math.floor((this.endTimeDate - now) / (60 * 60 * 1000));
        const minutesRemaining = Math.floor(((this.endTimeDate - now) % (60 * 60 * 1000)) / (60 * 1000));
        return `${hoursRemaining}h ${minutesRemaining}m`;
      } else {
        return 'Time to go home!';
      }
    },
  },
  methods: {
    initStars() {
      const starsEl = document.querySelector('.stars');
      for (let i = 0; i < 100; i++) {
        const star = document.createElement('div');
        star.className = 'star';
        star.style.left = `${Math.random() * 100}%`;
        star.style.top = `${Math.random() * 100}%`;
        star.dataset.speed = (Math.random() * 4.99 + 0.1).toFixed(2);
        starsEl.appendChild(star);
      }
    },
    moveStars(event) {
      const stars = document.querySelectorAll('.star');
      const { clientX, clientY } = event;
      stars.forEach((star) => {
        const speed = parseFloat(star.dataset.speed);

        const x = (this.windowSize.width / 2 - clientX) * speed / 50;
        const y = (this.windowSize.height / 2 - clientY) * speed / 50;

        star.style.transform = `translate(${x}px, ${y}px)`;
      });
    },
    calculateEndTime() {
      if (this.startTime != "") {
        this.endTime = new Date(this.endTimeDate.setMinutes(this.endTimeDate.getMinutes() + 1)).toTimeString().substr(0, 5);
        this.timeRemaining = this.timeRemainingComputed;
      }
    },
  },
  mounted() {
    this.initStars();
    window.addEventListener('mousemove', this.moveStars);
  },
};
</script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap');

body,
html {
  margin: 0;
  padding: 0;
  height: 100%;
  font-family: 'Quicksand', sans-serif;
  background: #0d0d0d;
  overflow: hidden;
}

#app {
  position: relative;
  height: 100%;
}

.container {
  position: absolute;
  top: 45%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
}

h1,
label,
p {
  color: #ffffff;
  text-shadow: 0 0 10px rgba(255, 255, 255, 0.7);
}

input,
button {
  background: rgba(255, 255, 255, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.4);
  outline: none;
  color: #ffffff;
  font-family: 'Quicksand', sans-serif;
  padding: 10px;
  margin: 0.75rem;
  border-radius: 5px;
  transition: background-color 0.3s ease;
}

input:focus,
button:focus {
  background: rgba(255, 255, 255, 0.3);
}

button {
  cursor: pointer;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

button:hover {
  background-color: rgba(255, 255, 255, 0.35);
}

button:disabled {
  background-color: rgba(255, 255, 255, 0.1);
  color: grey;
  cursor: not-allowed;
}

.stars {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.star {
  position: absolute;
  width: 2px;
  height: 2px;
  background: white;
  border-radius: 50%;
  opacity: 0.8;
  animation: twinkle 1.5s infinite alternate;
}

@keyframes twinkle {
  0% {
    opacity: 0.5;
  }

  100% {
    opacity: 0.8;
  }
}
</style>
