def store_hash hash, obj, key, val
    obj_key = obj.fetch key
    obj_val = obj.fetch val
    hash.store obj_key, obj_val
end

def push_array array, obj, val
    obj_val = obj.fetch val
    array.push obj_val
end

def conv_key_val obj, key, val
    hash = {}
    store_hash hash, obj, key, val
    return hash
end

def conv_key_vals obj, key, vals
    hash = {}
    array = []

    obj_key = obj.fetch key
    for val in vals
        push_array array, obj, val
    end

    hash.store obj_key, array
    return hash
end

def objs_conv_key_val objs, key, val
    hash = {}
    for obj in objs
        store_hash hash, obj, key, val
    end
    return hash
end

def objs_conv_key_vals objs, key, vals
    hash = {}
    for obj in objs
        array = []

        obj_key = obj.fetch key
        for val in vals
            push_array array, obj, val
        end
    
        hash.store obj_key, array
    end
    return hash
end
