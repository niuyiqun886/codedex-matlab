
|  符号  | line style |
| :--: | :--------: |
| '-'  |     实线     |
| '--' |     虚线     |
| ':'  |     点线     |
| '-.' |    点划线     |




Marker symbol
加号：'+'
圆圈：'o'
星号：'*'
点：'.'
叉号：'x'
方块：'square'或's'
钻石：'diamond'或'd'
向上的三角：'^'
向下的三角：'v'
向左的三角：'<'
向右的三角：'>'
五角星：'pentagra'或'p'
六角星：'hexagram'或'h'


color
红色：'r'
绿色：'g'
蓝色：'b'
蓝绿色：'c'
洋红色：'m'
黄色：'y'
黑色：'k'
白色：'w'


x,y轴范围进行调整：axis([Xmin,Xmax,Ymin,Ymax])
标注x轴的名称：xlabel('string')
标注y轴的名称：ylabel('string')
标注图形标题：title('string')
标注图例标注：legend('string1','string2','string3',...)
给图形增加网格：grid on
给图形取消网格：grid off
在图形中加入普通文本标注：gtext('string')


matlab的特殊二维曲线绘制
函数以及调用格式        意义
bar(x,y)              二维条形图
stem(x,y)             火柴杆图
stairs(x,y)           阶梯图
polar(x,y)            极坐标图
loglog(x,y)           对数图
area(x,y)             面积图


matlab图形窗口控制函数及其功能说明
函数             功能说明
figure           每调用一次就打开一个新的图形窗口
figure(n)        创建或打开第n个图形窗口，使之成为当前窗口
clf              清楚当前图形窗口
hold on          保留当前窗口的图形不被后继图形覆盖，可实现在同一坐标系中多幅图形的重叠
hold off         解除hold on命令，一般与hold on成对使用
subplot(m,n,p)   使当前绘图窗口分割成m行n列，并在p个区域绘图
close            关闭当前图形窗口
close all        关闭所有图形窗口


matlab三维曲面绘制函数
函数                   功能说明
[X,Y]=meshgrid(x,y)    根据(x,y)二维坐标数据生成xy网格点
                       坐标数据，其中，x、y是向量，X、Y是矩阵
mesh(X,Y,Z)            绘制三维网络曲面，通过直线连接相邻的点构成三维曲面
surf(X,Y,Z)            绘制三维阴影曲面，通过小平面连接相邻的点构成三维曲面



























