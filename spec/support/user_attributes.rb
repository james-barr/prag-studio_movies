def user_attributes(override = {} )
  {
    name: "Al",
    email: "y@g.com",
    password: "cat",
    password_confirmation: "cat"
  }.merge override
end
def user_attributes2(override = {})
  {
    name: "Mary",
    email: "m@x.com",
    password: "meow",
    password_confirmation: "meow"
  }.merge override
end
def user_attributes3 override = {}
  {
    name: "Sean",
    email: "sean@x",
    password: "s1",
    password_confirmation: "s1"
  }.merge override
end

public

def v?
  valid?
end

def e(*args)
  expect(*args)
end

def present_user_created(object)
  object.created_at.strftime("%B %d, %Y")
end
