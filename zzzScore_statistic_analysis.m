%% 微型赛道  注意！！！！本程序要求的csv文件需要是已经做完归一化求平均的结果而不是说直接读取所有人的打分
filename = 'zz微型分数.csv';
% 使用 textscan 更精确控制读取
fid = fopen(filename, 'r');
formatSpec = '%s %f'; % 第一列字符串，第二列浮点数
dataArray = textscan(fid, formatSpec, 'Delimiter', ',	', 'HeaderLines', 0);
fclose(fid);
% 转换为表格
data = table(dataArray{1}, dataArray{2}, 'VariableNames', {'ArtWorkName', 'AverageScore'});
% 显示读取的数据
% disp('成功读取数据:');
% disp(data(1:min(5, height(data)), :)); % 显示前5行数据
% 1. 按分数排序（降序）
sortedData = sortrows(data, 'AverageScore', 'descend');
disp('微型赛道排名（前14晋级复审）:');
disp(sortedData(1:min(100, height(sortedData)), :));
% 2. 绘制直方图
figure;
histogram(data.AverageScore, 'BinWidth', 5, 'FaceColor', [0.5 0.7 1]);
title('微型作品得分分布');
xlabel('平均分');
ylabel('作品数量');
grid on;

%% 短篇赛道
filename = 'zz短篇分数.csv';
% 使用 textscan 更精确控制读取
fid = fopen(filename, 'r');
formatSpec = '%s %f'; % 第一列字符串，第二列浮点数
dataArray = textscan(fid, formatSpec, 'Delimiter', ',	', 'HeaderLines', 0);
fclose(fid);
% 转换为表格
data_dp = table(dataArray{1}, dataArray{2}, 'VariableNames', {'ArtWorkName', 'AverageScore'});
% 显示读取的数据
% disp('成功读取数据:');
% disp(data(1:min(5, height(data)), :)); % 显示前5行数据
% 1. 按分数排序（降序）
sortedData = sortrows(data_dp, 'AverageScore', 'descend');
disp('短篇赛道排名（前24晋级复审）:');
disp(sortedData(1:min(100, height(sortedData)), :));
% 2. 绘制直方图
figure;
histogram(data_dp.AverageScore, 'BinWidth', 5, 'FaceColor', [0.5 0.7 1]);
title('短篇作品得分分布');
xlabel('平均分');
ylabel('作品数量');
grid on;

%% 无限制赛道
filename = 'zz无限制分数.csv';
% 使用 textscan 更精确控制读取
fid = fopen(filename, 'r');
formatSpec = '%s %f'; % 第一列字符串，第二列浮点数
dataArray = textscan(fid, formatSpec, 'Delimiter', ',	', 'HeaderLines', 0);
fclose(fid);
% 转换为表格
data_wxz = table(dataArray{1}, dataArray{2}, 'VariableNames', {'ArtWorkName', 'AverageScore'});
% 显示读取的数据
% disp('成功读取数据:');
% disp(data(1:min(5, height(data)), :)); % 显示前5行数据
% 1. 按分数排序（降序）
sortedData = sortrows(data_wxz, 'AverageScore', 'descend');
disp('无限制赛道排名（前10晋级复审）:');
disp(sortedData(1:min(100, height(sortedData)), :));
% 2. 绘制直方图
figure;
histogram(data_wxz.AverageScore, 'BinWidth', 5, 'FaceColor', [0.5 0.7 1]);
title('无限制作品得分分布');
xlabel('平均分');
ylabel('作品数量');
grid on;

%% 创新赛道
filename = 'zz创新分数.csv';
% 使用 textscan 更精确控制读取
fid = fopen(filename, 'r');
formatSpec = '%s %f'; % 第一列字符串，第二列浮点数
dataArray = textscan(fid, formatSpec, 'Delimiter', ',	', 'HeaderLines', 0);
fclose(fid);
% 转换为表格
data_cx = table(dataArray{1}, dataArray{2}, 'VariableNames', {'ArtWorkName', 'AverageScore'});
% 显示读取的数据
% disp('成功读取数据:');
% disp(data(1:min(5, height(data)), :)); % 显示前5行数据
% 1. 按分数排序（降序）
sortedData = sortrows(data_cx, 'AverageScore', 'descend');
disp('创新赛道排名（前4晋级复审）:');
disp(sortedData(1:min(100, height(sortedData)), :));
% 2. 绘制直方图
figure;
histogram(data_cx.AverageScore, 'BinWidth', 5, 'FaceColor', [0.5 0.7 1]);
title('创新作品得分分布');
xlabel('平均分');
ylabel('作品数量');
grid on;

%% 3. 绘制箱线图(所有赛道都有了再说)
% 将所有数据集的分数收集到一个元胞数组中
allScores = [[data.AverageScore]; [data_dp.AverageScore]; [data_wxz.AverageScore]; [data_cx.AverageScore]];
oringins=[ones(size([data.AverageScore]));2*ones(size([data_dp.AverageScore]));3*ones(size([data_wxz.AverageScore]));4*ones(size([data_cx.AverageScore]))];
% 为每个数据集创建标签（根据需要修改）
groupLabels = {'微型', '短篇', '无限制', '创新'};
 
% 创建并排的箱线图
figure;
boxplot(allScores,oringins, 'Labels', groupLabels);
 
% 添加图表标题和标签
title('总体统计特性对比');
ylabel('Average Score');
grid on;
% figure;
% boxplot(ones(size(data.AverageScore)),data.AverageScore);hold on
% boxplot(2*ones(size(data_dp.AverageScore)),data_dp.AverageScore);
% boxplot(3*ones(size(data_wxz.AverageScore)),data_wxz.AverageScore);
% boxplot(4*ones(size(data_cx.AverageScore)),data_cx.AverageScore);
% title('得分箱线图');
% ylabel('作品平均分');
% grid on;
% legend('微型','短篇','无限制','创新')
