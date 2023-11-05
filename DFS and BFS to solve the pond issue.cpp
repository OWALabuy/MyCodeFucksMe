/*utf-8
LyoNCuWwj+axoOWhmOajgOa1i++8iOeoi+W6j+e7gyoqKumimO+8iQ0K5Lmg56aB6K+E5pu+6K+06L+H4oCc6L+Z5Liq5a6H5a6Z5aSq55av54uC77yM5aSn5rW35o6A57+75bCP5rGg5aGY44CC4oCd5LyX5omA5ZGo55+l77yM5Lmg56aB6K+E55Sf5rS75Zyo5qKB5a625rKz5YWF5ruh5rK85rCU55qE5bCP5rGg5aGY5ZKM5Lit5Y2X5rW355qE55av54uC5a6H5a6Z5Lit44CC5Zyo5Lmg5pyd5aKZ5Zu96YeM77yM5pyJ6Z2e5bi45aSa55qE5bCP5rGg5aGY44CC546w5Zyo5oiR5Lus55SoMeS7o+ihqOmZhuWcsO+8jDDku6PooajmsLTln5/vvIzov57miJDkuIDniYfnmoTmsLTln5/vvIgw77yJ5bCx5piv5LiA5Liq5rGg5aGY77yM6K+357yW5YaZ5LiA5Liq57uf6K6h5aKZ5Zu95bCP5rGg5aGY5pWw55uu55qE56iL5bqP44CCDQrovpPlhaXnmoTnrKzkuIDooYznu5nlh7ropoHnu5/orqHnmoTlnLDlm77mgLvmlbDvvIzmjqXkuIvmnaXnmoTkuIDooYznu5nlh7rnrKzkuIDlvKDlnLDlm77nmoTooYzmlbDnmoTliJfmlbDvvIznhLblkI7nu5nlh7rov5nlvKDlnLDlm77jgILnqIvluo/liKTmlq3lkI7ovpPlh7rlnLDlm77kuK3lsI/msaDloZjnmoTkuKrmlbDjgILnhLblkI7ovpPlhaXkuIvkuIDlvKDlnLDlm77igKbigKYNCuekuuS+i++8mg0KMw0KMyA0DQowIDAgMSAwDQowIDAgMSAxDQoxIDEgMSAwDQpvdXRwdXQ+IDMNCjUgNg0KMCAwIDEgMCAwIDANCjAgMCAxIDEgMCAxDQoxIDEgMCAwIDEgMA0KMCAwIDEgMSAxIDANCjAgMSAwIDAgMCAxDQpvdXRwdXQ+IDYNCiovDQo=
*/

#include <iostream>
#include <vector>

using namespace std;

// 定义方向数组，用于在DFS中遍历相邻的点
const int dx[] = {-1, -1, -1, 0, 1, 1, 1, 0};
const int dy[] = {-1, 0, 1, 1, 1, 0, -1, -1};

// 深度优先搜索函数
void DFS(vector<vector<int>>& grid, int x, int y)
{
    // 标记当前点为已访问
    grid[x][y] = -1;
    
    // 遍历当前点的8个相邻点
    for (int i = 0; i < 8; i++)
    {
        int nx = x + dx[i];
        int ny = y + dy[i];
        
        // 检查相邻点是否合法，并且是小池塘
        if (nx >= 0 && nx < grid.size() && ny >= 0 && ny < grid[0].size() && grid[nx][ny] == 0)
        {
            DFS(grid, nx, ny); // 递归遍历相邻点
        }
    }
}

int main()
{
    int numMaps;
    cin >> numMaps;
    
    while (numMaps--)
    {
        int rows, cols;
        cin >> rows >> cols;
        
        vector<vector<int>> grid(rows, vector<int>(cols));
        int pondCount = 0; // 统计小池塘数量
        
        // 读取地图数据
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < cols; j++)
            {
                cin >> grid[i][j];
            }
        }
        
        // 遍历整个地图
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < cols; j++)
            {
                if (grid[i][j] == 0)
                {
                    // 遇到小池塘，开始DFS
                    DFS(grid, i, j);
                    pondCount++;
                }
            }
        }
        
        cout << pondCount << endl;
    }
    
    return 0;
}

#include <iostream>
#include <vector>
#include <queue>

using namespace std;

// 定义方向数组，用于在BFS中遍历相邻的点
const int dx[] = {-1, -1, -1, 0, 1, 1, 1, 0};
const int dy[] = {-1, 0, 1, 1, 1, 0, -1, -1};

// 定义点的结构体
struct Point
{
    int x;
    int y;
    Point(int _x, int _y) : x(_x), y(_y) {}
};

// 广度优先搜索函数
void BFS(vector<vector<int>>& grid, int x, int y)
{
    // 创建队列并将起始点入队
    queue<Point> q;
    q.push(Point(x, y));
    
    // 标记当前点为已访问
    grid[x][y] = -1;
    
    // 开始BFS
    while (!q.empty())
    {
        Point cur = q.front();
        q.pop();
        
        // 遍历当前点的8个相邻点
        for (int i = 0; i < 8; i++)
        {
            int nx = cur.x + dx[i];
            int ny = cur.y + dy[i];
            
            // 检查相邻点是否合法，并且是小池塘
            if (nx >= 0 && nx < grid.size() && ny >= 0 && ny < grid[0].size() && grid[nx][ny] == 0)
            {
                // 将相邻点入队并标记为已访问
                q.push(Point(nx, ny));
                grid[nx][ny] = -1;
            }
        }
    }
}

int main()
{
    int numMaps;
    cin >> numMaps;
    
    while (numMaps--)
    {
        int rows, cols;
        cin >> rows >> cols;
        
        vector<vector<int>> grid(rows, vector<int>(cols));
        int pondCount = 0; // 统计小池塘数量
        
        // 读取地图数据
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < cols; j++)
            {
                cin >> grid[i][j];
            }
        }
        
        // 遍历整个地图
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < cols; j++
              {
                if (grid[i][j] == 0)
                {
                    // 遇到小池塘，开始BFS
                    BFS(grid, i, j);
                    pondCount++;
                }
            }
        }
        
        cout << pondCount << endl;
    }
    
    return 0;
}
