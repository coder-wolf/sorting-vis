void BubbleSort(arr, foo) {
  for (int i = 0; i < arr.length; i++) {
    for (int j = 0; j < arr.length; j++) {
      if (arr[i] < arr[j]) {
        foo();
      }
    }
  }
}
