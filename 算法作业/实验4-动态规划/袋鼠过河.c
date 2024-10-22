#include <stdio.h>

int minJumps(int n, int arr[]) {
    if (n == 1) {
        return 1;  // 袋鼠已经在终点
    }
    
    int jumps = 1;          // 记录跳跃次数
    int farthest = 0;       // 袋鼠能跳到的最远距离
    int currentEnd = 0;     // 当前这次跳跃的终点

    for (int i = 0; i < n - 1; i++) {
        // 更新袋鼠能跳到的最远距离
        farthest = (i + arr[i] > farthest) ? i + arr[i] : farthest;

        // 如果无法再继续跳跃，返回 -1
        if (farthest <= i) {
            return -1;
        }

        // 如果已经到达当前这次跳跃的最远距离，增加一次跳跃
        if (i == currentEnd) {
            jumps++;
            currentEnd = farthest;

            // 如果袋鼠能跳到终点，返回跳跃次数
            if (currentEnd >= n - 1) {
                return jumps;
            }
        }
    }

    // 如果袋鼠无法到达终点
    return -1;
}

int main() {
    int n;

    // 输入数组的长度
    scanf("%d", &n);

    int arr[n];

    // 输入弹簧的力量数组
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    // 调用函数，输出最少的跳跃次数
    int result = minJumps(n, arr);

    printf("%d\n", result);

    return 0;
}

