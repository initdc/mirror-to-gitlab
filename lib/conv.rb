# frozen_string_literal: true

def store_hash(hash, obj, key, val)
  obj_key = obj.fetch(key)
  obj_val = obj.fetch(val)
  hash.store(obj_key, obj_val)
end

def push_array(array, obj, val)
  obj_val = obj.fetch(val)
  array.push(obj_val)
end

def conv_key_val(obj, key, val)
  hash = {}
  store_hash(hash, obj, key, val)
  return hash
end

def conv_key_vals(obj, key, vals)
  hash = {}
  array = []

  obj_key = obj.fetch(key)
  vals.each do |val|
    push_array(array, obj, val)
  end

  hash.store(obj_key, array)
  return hash
end

def objs_conv_key_val(objs, key, val)
  hash = {}
  objs.each do |obj|
    store_hash(hash, obj, key, val)
  end
  return hash
end

def objs_conv_key_vals(objs, key, vals)
  hash = {}
  objs.each do |obj|
    array = []

    obj_key = obj.fetch(key)
    vals.each do |val|
      push_array(array, obj, val)
    end

    hash.store(obj_key, array)
  end
  return hash
end
