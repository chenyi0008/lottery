$(function(){
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        laydate.render({
            elem: '.layui-datetime',
            type: 'datetime',
            trigger: 'click'
        });
    });
})



