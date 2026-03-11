import { ref } from "vue";
import { defineStore } from "pinia";


export const useMockStore = defineStore("mock", () => {
  // State
  const counter = ref(0);

  // Actions
  function increment() {
    counter.value++;
  }

  function decrement() {
    if (counter.value > 0)
      counter.value--;
  }

  return {
    // State
    counter,
    // Actions
    increment,
    decrement,
  };
});