package br.ufg.inf.mud.base;


public interface Exit {
    public String leaveMessage();
    public String joinMessage();
    public String ownMessage();
    public Room getRoom(Room room);
}
