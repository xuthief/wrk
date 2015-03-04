-- example HTTP POST script which demonstrates setting the
-- HTTP method, body, and adding a header

action = "add"

maxuid = 100000
maxuidperslice = 4000
maxappkey = 10
maxtopic = 1000
maxslice = math.floor(maxuid/maxuidperslice)

septopic = maxslice 
sepappkey = maxslice * maxtopic
maxindex = maxappkey * maxtopic * maxslice

math.randomseed(os.time())
index = math.random(maxindex)

request = function()
    index = (index + 1) % maxindex
    indexappkey = math.floor(index / sepappkey)
    indextopic = math.floor(index / septopic)

    appkey = "appkey" .. indexappkey
    topic = "topic" .. indextopic
    slice = index % maxslice

    wrk.method = "GET"

    url = wrk.format(nil, "/" .. appkey .. "/" .. topic .. ":" .. slice .. "/?type=FS")
    return url
end
