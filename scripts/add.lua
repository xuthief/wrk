-- example HTTP POST script which demonstrates setting the
-- HTTP method, body, and adding a header

action = "add"

maxuid = 100000
maxappkey = 10
maxtopic = 1000
septopic = maxuid
sepappkey = maxuid * maxtopic
maxindex = maxuid * maxappkey * maxtopic

os.execute("sleep 2");
math.randomseed(os.time() * 100)
index = math.random(maxindex)

request = function()
    index = (index + 1) % maxindex
    uid = index % maxuid
    indexappkey = math.floor(index / sepappkey)
    indextopic = math.floor(index / septopic)

    wrk.method = "POST"
    wrk.headers["Content-Type"] = "application/json"

    cid = "" .. indexappkey .. "-" .. uid
    appkey = "appkey" .. indexappkey
    topic = "topic" .. indextopic
    wrk.body = '{"action":"' .. action .. '", "topic":"' .. appkey .. '/' .. topic .. '", "uid":"' .. uid .. '", "cid":"' .. cid .. '", "platform": 1}'

    --print(wrk.body)

    return wrk.format(nil, "/.topicfs")
end
