    Array.prototype.find=function(callback){
        var ret = [];
        for(var i=0,l=this.length;i<l;i++){
            if(callback(this[i]))
                ret.push(this[i]);
        }
        return ret.length <= 0 ? null : ret;
    }


    function getSourceObj(sourceText) {
        // 清除不需要的信息
        sourceText = sourceText.replace(/\/\/.+/g, "");
        sourceText = sourceText.replace(/@availability/g, "");

        var sourceObj = {
            className: "",
            superClass: "",
            protocolNames: [""],
            delegateAttributeNames: [""],
            funcs: [{
                oldName: "",
                newName: "",
                parameters: [{
                    name: "",
                    variate: "",
                    type: ""
                }],
                returnType: ""
            }]
        };


        // 解析类定义
        var re = /^ *([A-Z]{1}(\w+)) *: *(\w+)(?:, \w+)*/;
        var result = re.exec(sourceText);
        if (result == null) {
            console.error("缺少类定义信息");
            return null;
        }
        sourceObj.className = result[1];
        var classChildName = result[2];
        sourceObj.superClass = result[3];

        sourceText = sourceText.replace(re, "");

        // 解析协议
        sourceObj.protocolNames = [];
        re = /, (\w+)/g;
        var str = result[0];
        while ((result = re.exec(str)) !== null) {
            sourceObj.protocolNames.push(result[1]);
        }

        // 解析delegate属性列表
        sourceObj.delegateAttributeNames = ["delegate"];
        re = /DELEGATE_LIST\:(\w+)( *, *\w+)*/;
        result = re.exec(sourceText);
        if (result !== null) {
            sourceText = sourceText.replace(re, "");

            sourceObj.delegateAttributeNames = [result[1]];

            re = / *, *(\w+)/g;
            var str = result[0];
            while ((result = re.exec(str)) !== null) {
                if (sourceObj.delegateAttributeNames.indexOf(result[1]) < 0)
                    sourceObj.delegateAttributeNames.push(result[1]);
            }
        }

        // 解析方法
        sourceObj.funcs = [];
        re = / *(?:optional |public )*func (\w+)\(((?:_|\w+) ?)(\w+): (\w+(?:<\w+>)?\??)[^\n]+/g;
        while ((result = re.exec(sourceText)) !== null) {
            var funcStr = result[0];
            var reg = new RegExp(classChildName, "i");
            var funcObj = {
                oldName: result[1],
                newName: "_" + result[1],
                parameters: [{
                    name: result[2] ? result[2].trim() : result[3],
                    variate: result[3],
                    type: result[4]
                }],
                returnType: undefined
            }

            // 更多的参数
            var BLOCK_REGEXP_STR = "(?:\@escaping )\\([ ,<>\\[\\:\\]\\w\\!\\?]+\\) -> (?:\\w+!?\\??)?"; 
            var TYPE_REGEXP_STR = "[ <>\\[\\:\\]\\w\\!\\?]+|" + BLOCK_REGEXP_STR + "|\\(" + BLOCK_REGEXP_STR + "\\)";
            var tRegExp = new RegExp(",(?: (\\w+))? (\\w+): (" + TYPE_REGEXP_STR + ")", "g");
            while ((r = tRegExp.exec(funcStr)) !== null) {
                funcObj.parameters.push({
                    name: r[1] ? r[1] : r[2],
                    variate: r[2],
                    type: r[3].replace(/^\s+|[\s\!]+$/g,"")
                });
            }

            // 确定方法名称
            if (funcObj.parameters.length >= 1 && funcObj.parameters[0].name !== "_") {
                funcObj.newName += "_" + firstLetterLowercase(funcObj.parameters[0].name);
            } else if (funcObj.parameters.length >= 2 && funcObj.parameters[0].name === "_") {
                funcObj.newName += "_" + firstLetterLowercase(funcObj.parameters[1].name);
            }

            // 判断方法名是否已存在，存在则在方法名上加上之后的参数名
            var i = 0;
            while (sourceObj.funcs.find(function(item){ return item.newName === funcObj.newName; })) {
                if (funcObj.parameters.length <= i) {
                    console.log(funcObj);
                    console.error("无法解析，需要第" + i + "个参数来确定方法名。请看控制台日志");
                    return null;
                }
                if (funcObj.parameters[i].name === "_") {
                    i++;
                    continue;
                }
                funcObj.newName += "_" + firstLetterLowercase(funcObj.parameters[i].name);
            }

            // 返回类型
            var tRegExp = new RegExp(" -> (" + TYPE_REGEXP_STR + ")$");
            if ((r = tRegExp.exec(funcStr)) !== null)
                funcObj.returnType = r[1].trim();

            sourceObj.funcs.push(funcObj);
        }
        return sourceObj;
    }

    function getCurrectDateStr() {
        var d = new Date();
        var day = d.getDate();
        var month = d.getMonth() + 1;
        var year = d.getFullYear();
        var date = year + "/" + month + "/" + day;
        return date;
    }
    function firstLetterUppercase(str) {
        return str.substring(0,1).toUpperCase() + str.substring(1);
    }
    function firstLetterLowercase(str) {
        return str.substring(0,1).toLowerCase() + str.substring(1);
    }
    function getFuncReturnType(returnType) {
        return returnType ? returnType : "Void";
    }

    function getConvertContent(frameworkName, sourceObj) {
        // 扩展缩写名
        var EXT_NAME_ACRONYM = "ce";
        var CLASS_DELEGATE_NAME = sourceObj.className + "_Delegate"
        var resultContent = "";

        // 需要赋值的delegate属性
        var delegateAttributeStr = "";
        for (var i = 0; i < sourceObj.delegateAttributeNames.length; i++) {
            delegateAttributeStr += "        self." + sourceObj.delegateAttributeNames[i] + " = nil\n";
            delegateAttributeStr += "        self." + sourceObj.delegateAttributeNames[i] + " = delegate\n";
        };

        // 生成扩展类
        //      方法
        var funcStr = "";
        for (var i = 0; i < sourceObj.funcs.length; i++) {
            var funcObj = sourceObj.funcs[i];
            // 参数串
            var paramtStr = "";
            for (var j = 0; j < funcObj.parameters.length; j++) {
                var paramtObj = funcObj.parameters[j];
                if (paramtStr.length > 0)
                    paramtStr += ", ";
                paramtStr += paramtObj.type;
            };

            funcStr += "\
    @discardableResult\n\
    public func " + EXT_NAME_ACRONYM + funcObj.newName + "(handle: @escaping (" + paramtStr + ") -> " + getFuncReturnType(funcObj.returnType) + ") -> Self {\n\
        " + EXT_NAME_ACRONYM + "." + funcObj.newName + " = handle\n\
        rebindingDelegate()\n\
        return self\n\
    }\n";
        };
        funcStr += "    ";


        //      最终的扩展类
        resultContent = "\
//\n\
//  CE_" + sourceObj.className + ".swift\n\
//  Centipede\n\
//\n\
//  Created by kelei on " + getCurrectDateStr() + ".\n\
//  Copyright (c) " + (new Date()).getFullYear() + "年 kelei. All rights reserved.\n\
//\n\
\n\
import " + frameworkName + "\n\
\n\
extension " + sourceObj.className + " {\n\
    \n\
    private struct Static { static var AssociationKey: UInt8 = 0 }\n\
    private var _delegate: " + CLASS_DELEGATE_NAME + "? {\n\
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? " + CLASS_DELEGATE_NAME + " }\n\
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }\n\
    }\n\
    \n\
    private var " + EXT_NAME_ACRONYM + ": " + CLASS_DELEGATE_NAME + " {\n\
        if let obj = _delegate {\n\
            return obj\n\
        }\n\
        if let obj: AnyObject = self." + sourceObj.delegateAttributeNames[0] + " {\n\
            if obj is " + CLASS_DELEGATE_NAME + " {\n\
                return obj as! " + CLASS_DELEGATE_NAME + "\n\
            }\n\
        }\n\
        let obj = getDelegateInstance()\n\
        _delegate = obj\n\
        return obj\n\
    }\n\
    \n\
    private func rebindingDelegate() {\n\
        let delegate = ce\n" + delegateAttributeStr + "\
    }\n\
    \n\
    internal" + (sourceObj.superClass === "NSObject" ? "" : " override") + " func getDelegateInstance() -> " + CLASS_DELEGATE_NAME + " {\n\
        return " + CLASS_DELEGATE_NAME + "()\n\
    }\n\
    \n\
" + funcStr + "\n\
}\n";

        // 生成代理对象
        //      生成协议串
        var protocolStr = sourceObj.protocolNames.join(", ");
        //      生成成员变量
        var classVarStr = "    ";
        for (var i = 0; i < sourceObj.funcs.length; i++) {
            var funcObj = sourceObj.funcs[i];
            // 参数串
            var paramtStr = "";
            for (var j = 0; j < funcObj.parameters.length; j++) {
                var paramtObj = funcObj.parameters[j];
                if (paramtStr.length > 0)
                    paramtStr += ", ";
                paramtStr += paramtObj.type;
            };

            classVarStr += "var " + funcObj.newName + ": ((" + paramtStr + ") -> " + getFuncReturnType(funcObj.returnType) + ")?\n    ";
        };
        //      生成respondsToSelector内容
        var respondsStr = "";
        var count = 0, groupIndex = 1;

        for (var i = 0; i < sourceObj.funcs.length;) {
            var funcObj = sourceObj.funcs[i]
            // 头
            if (count === 0) {
                respondsStr += "\n        let funcDic" + groupIndex + ": [Selector : Any?] = [\n";
            }
            // 内容
            respondsStr += "            #selector("
            for (var j = 0; j < funcObj.parameters.length; j++) {
                var paramtObj = funcObj.parameters[j];

                if (j === 0) {
                    respondsStr += funcObj.oldName + "(";
                }
                respondsStr += paramtObj.name + ":";
            };
            respondsStr += ")) : " + funcObj.newName + ",\n";
            // 尾
            count++;
            i++;
            if (count >= 7 || i >= sourceObj.funcs.length) {
                respondsStr += "\
        ]\n\
        if let f = funcDic" + groupIndex + "[aSelector] {\n\
            return f != nil\n\
        }\n        ";
                count = 0;
                groupIndex++;
            }
        };

        //      生成实现协议方法
        var funcStr = "";
        for (var i = 0; i < sourceObj.funcs.length; i++) {
            var funcObj = sourceObj.funcs[i]
            // 参数串
            var parameterStr = "", argumentStr = "";
            for (var j = 0; j < funcObj.parameters.length; j++) {
                var paramtObj = funcObj.parameters[j];

                if (parameterStr.length > 0)
                    parameterStr += ", ";

                if (paramtObj.name === paramtObj.variate)
                    parameterStr += (paramtObj.variate + ": " + paramtObj.type);
                else
                    parameterStr += paramtObj.name + " " + paramtObj.variate + ": " + paramtObj.type;

                if (argumentStr.length > 0)
                    argumentStr += ", ";
                argumentStr += paramtObj.variate;
            };
            // 返回值
            var returnStr = funcObj.returnType ? " -> " + funcObj.returnType : "";
            funcStr += "\n\
    @objc func " + funcObj.oldName + "(" + parameterStr + ")" + returnStr + " {\n\
        " + (funcObj.returnType ? "return " : "") + funcObj.newName + "!(" + argumentStr + ")\n\
    }";
        };
        //      最终实现的协议对象
        resultContent += "\n\
internal class " + CLASS_DELEGATE_NAME + ": " + sourceObj.superClass + (sourceObj.superClass === "NSObject" ? "" : "_Delegate") + (protocolStr.length > 0 ? ", " + protocolStr : "")+ " {\n\
    \n" + classVarStr + "\n\
    \n\
    override func responds(to aSelector: Selector!) -> Bool {\n\
        " + respondsStr + "\n\
        return super.responds(to: aSelector)\n\
    }\n\
    \n\
    " + funcStr + "\n\
}\n";

        return resultContent;
    }

var fs = require('fs');
var path = require('path');

// 取得path目录下所有文件列表（包含子目录）
function walk(aPath){
    var ret = [];

    function headle(aPath) {
        var dirList = fs.readdirSync(aPath);

        dirList.forEach(function(item){
            if(fs.statSync(aPath + '/' + item).isFile()){
                ret.push(aPath + '/' + item);
            }
        });

        dirList.forEach(function(item){
            if(fs.statSync(aPath + '/' + item).isDirectory()){
                headle(aPath + '/' + item);
            }
        });

    }
    headle(aPath);

    return ret;
}

var currentDirLevel = __dirname.split(path.sep).length;
var files = walk(__dirname);
// 生成文件
files.forEach(function(item){
    var ext = path.extname(item);
    if (ext !== '.txt') {
        return;
    }
    
    fs.readFile(item, 'utf8', function(err, data) { 
        if(err) { 
            console.error(item, 'READ ERROR:', err);
            return;
        }
        var sourceObj = getSourceObj(data);
        if (sourceObj == null) {
            console.error(item, 'getSourceObj ERROR');
            return;
        }
        
        var frameworkName = item.split(path.sep)[currentDirLevel];
        var resultContent = getConvertContent(frameworkName, sourceObj);

        var dirnames = item.split(path.sep);
        var filename = path.basename(dirnames.pop(), '.txt');
        var kitname = dirnames.pop();
        dirnames.pop();

        dirnames.push('Centipede', kitname);
        var targetPath = dirnames.join(path.sep);
        var targetFile = 'CE_' + filename + '.swift';

        if (!fs.existsSync(targetPath)) {
            fs.mkdirSync(targetPath);
        }
        var target = path.join(targetPath, targetFile);
        console.log(target); 
        fs.writeFile(target, resultContent, {encoding: 'utf8'}, function(err) {
            if (err) throw err;
        });
    });
});
