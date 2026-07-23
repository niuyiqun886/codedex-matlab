%% 简单 CNN 手写数字识别 Demo
% 展示：数据加载 → 网络结构 → 训练 → 评估 的完整流程

clc; clear; close all;

%% 1. 加载数据
dataFolder = fullfile(toolboxdir('nnet'), 'nndemos', 'nndatasets', 'DigitDataset');
imds = imageDatastore(dataFolder, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

% 划分训练集 80% / 测试集 20%
[imdsTrain, imdsTest] = splitEachLabel(imds, 0.8, 'randomize');

fprintf('训练集：%d 张\n', numel(imdsTrain.Files));
fprintf('测试集：%d 张\n', numel(imdsTest.Files));

% 显示几张样本图片
figure('Name', '数据样本');
for i = 1:9
    subplot(3, 3, i);
    img = readimage(imdsTrain, i);
    imshow(img);
    title(string(imdsTrain.Labels(i)));
end
sgtitle('训练集样本（标签 = 数字类别）');

%% 2. 定义 CNN 网络结构
% 输入：28×28 灰度图
% 结构：Conv→BN→ReLU→MaxPool → Conv→BN→ReLU→MaxPool → FC→Softmax
layers = [
    imageInputLayer([28 28 1], 'Name', 'input', 'Normalization', 'zerocenter')

    % 第一卷积块：提取低级特征（边缘、角点）
    convolution2dLayer(3, 8, 'Padding', 'same', 'Name', 'conv1')   % 8个3×3卷积核
    batchNormalizationLayer('Name', 'bn1')                          % 批归一化，稳定训练
    reluLayer('Name', 'relu1')                                      % 激活函数
    maxPooling2dLayer(2, 'Stride', 2, 'Name', 'pool1')             % 下采样 28→14

    % 第二卷积块：提取高级特征（形状、结构）
    convolution2dLayer(3, 16, 'Padding', 'same', 'Name', 'conv2')  % 16个3×3卷积核
    batchNormalizationLayer('Name', 'bn2')
    reluLayer('Name', 'relu2')
    maxPooling2dLayer(2, 'Stride', 2, 'Name', 'pool2')             % 下采样 14→7

    % 全连接层：将特征映射到类别
    fullyConnectedLayer(10, 'Name', 'fc')                          % 10类（0-9）
    softmaxLayer('Name', 'softmax')                                % 输出概率
    classificationLayer('Name', 'output')
];

% 打印网络结构
analyzeNetwork(layers);

%% 3. 设置训练参数
options = trainingOptions('adam', ...           % Adam 优化器
    'MaxEpochs', 10, ...                        % 训练 10 轮
    'MiniBatchSize', 64, ...                    % 每批 64 张
    'InitialLearnRate', 0.001, ...              % 初始学习率
    'ValidationData', imdsTest, ...             % 用测试集监控验证精度
    'ValidationFrequency', 30, ...              % 每 30 步验证一次
    'Plots', 'training-progress', ...           % 显示训练进度图
    'Verbose', true);                           % 打印训练日志

%% 4. 训练模型
fprintf('\n开始训练...\n');
net = trainNetwork(imdsTrain, layers, options);

%% 5. 评估模型
YPred = classify(net, imdsTest);
YTest = imdsTest.Labels;

accuracy = sum(YPred == YTest) / numel(YTest);
fprintf('\n测试集准确率：%.2f%%\n', accuracy * 100);

% 混淆矩阵
figure('Name', '混淆矩阵');
confusionchart(YTest, YPred);
title(sprintf('混淆矩阵（准确率 %.2f%%）', accuracy * 100));

%% 6. 可视化预测结果
figure('Name', '预测结果');
for i = 1:9
    subplot(3, 3, i);
    img = readimage(imdsTest, i);
    imshow(img);
    pred = YPred(i);
    true_label = YTest(i);
    if pred == true_label
        title(sprintf('预测:%s ✓', string(pred)), 'Color', 'g');
    else
        title(sprintf('预测:%s 真:%s', string(pred), string(true_label)), 'Color', 'r');
    end
end
sgtitle('测试集预测结果');

fprintf('\n完成！\n');
