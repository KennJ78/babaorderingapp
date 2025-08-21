const HISTORY_KEY = 'reservationsHistory';

class ReservationHistoryService {
  static list() {
    try {
      const raw = localStorage.getItem(HISTORY_KEY);
      return raw ? JSON.parse(raw) : [];
    } catch (e) {
      return [];
    }
  }

  static save(list) {
    localStorage.setItem(HISTORY_KEY, JSON.stringify(list));
    ReservationHistoryService.notifyUpdated();
  }

  static notifyUpdated() {
    try {
      window.dispatchEvent(new Event('reservationHistoryUpdated'));
    } catch (_) {}
  }

  static generateCode() {
    return 'RSV-' + Math.random().toString(36).substring(2, 8).toUpperCase();
  }

  static addReservation({ items, subtotal }) {
    const list = ReservationHistoryService.list();
    const code = ReservationHistoryService.generateCode();
    const id = `${Date.now()}`;
    const date = new Date().toISOString();
    const reservation = {
      id,
      code,
      date,
      status: 'Processing',
      deliveryFee: 0,
      subtotal,
      total: subtotal,
      items: items.map(i => ({
        id: i.id,
        name: i.name,
        price: i.price,
        qty: i.qty || 1,
        imagePath: i.imagePath
      }))
    };
    list.unshift(reservation);
    ReservationHistoryService.save(list);

    // Simulate status progression
    setTimeout(() => {
      ReservationHistoryService.updateStatus(id, 'Confirmed');
    }, 5000);
    setTimeout(() => {
      ReservationHistoryService.updateStatus(id, 'Ready for Pickup');
    }, 12000);

    return reservation;
  }

  static updateStatus(id, status) {
    const list = ReservationHistoryService.list();
    const idx = list.findIndex(r => r.id === id);
    if (idx >= 0) {
      list[idx] = { ...list[idx], status };
      ReservationHistoryService.save(list);
    }
  }

  static cancelReservation(id) {
    const list = ReservationHistoryService.list();
    const idx = list.findIndex(r => r.id === id);
    if (idx >= 0) {
      list[idx] = { ...list[idx], status: 'Cancelled' };
      ReservationHistoryService.save(list);
    }
  }

  static getByCode(code) {
    return ReservationHistoryService.list().find(r => r.code === code) || null;
  }
}

export default ReservationHistoryService;


