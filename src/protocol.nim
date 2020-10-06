import json, patty
export json, patty

type
  Role* = enum
    user, janny, admin

  User* = object
    role*: Role
    name*: string

variantp Event:
  Auth(name, password: string)
  Janny(jaName: string, state: bool)
  Joined(joName: string, role: Role)
  Left(leName: string)
  Renamed(oldName, newName: string)
  State(playing: bool, time: float)
  Message(meName, text: string)
  Clients(clients: seq[User])
  PlaylistLoad(urls: seq[string])
  PlaylistAdd(url: string)
  PlaylistPlay(index: int)
  PlaylistClear
  Success
  Error(reason: string)
  Null

proc unpack*(ev: string): Event =
  if ev.len == 0: return Null()
  parseJson(ev).to(Event)

proc `==`*(u1: User, u2: User): bool =
  return u1.name == u2.name

proc `==`*(u1: User, s: string): bool =
  return u1.name == s