int positiveSum(List<int> arr) {
  int sum = 0;
  for (var num in arr) {
    if (num > 0) {
      sum += num;
    }
  }
  return sum;
}
